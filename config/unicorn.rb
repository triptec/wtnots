# unicorn_rails -c config/unicorn.rb -E production -D

rails_env = ENV['RAILS_ENV'] || 'production'

worker_processes 4

preload_app true

timeout 30


socket_path = ''
pid_path = ''
eval(File.new('config/paths.rb').read)

listen socket_path, :backlog => 2048
pid pid_path

unicorn_logger = Logger.new("log/unicorn.log")
#unicorn_logger.formatter = Logger::Formatter.new
logger unicorn_logger

before_fork do |server, worker|
        old_pid = RAILS_ROOT + '/tmp/unicorn.pid.oldbin'
        if File.exists?(old_pid) && server.pid != old_pid
                begin
                        Process.kill("QUIT", File.read(old_pid).to_i)
                rescue Errno::ENOENT, Errno::ESRCH
                end
        end
end

after_fork do |server, worker|
        ActiveRecord::Base.establish_connection

        begin
                uid, gid = Process.euid, Process.egid
                user, group = 'triptec', 'triptec'
                target_uid = Etc.getpwnam(user).uid
                target_gid = Etc.getgrnam(group).gid
                worker.tmp.chown(target_uid, target_gid)
                if uid != target_uid || gid != target_gid
                        Process.initgroups(user, target_gid)
                        Process::GID.change_privilege(target_gid)
                        Process::UID.change_privilege(target_uid)
                end
        rescue => e
                raise e
        end
end
