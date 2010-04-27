require 'faker'

namespace :db do
  desc "Fill database with sample data"
  task :populate => :environment do
    Rake::Task['db:reset'].invoke
    User.create!(:username => "triptec",
                 :name => "Andreas Franzén",
                 :email => "triptec@gmail.com",
                 :password => "foobar",
                 :password_confirmation => "foobar",
                 :openid_identifier => "")
    99.times do |n|
      username = Faker::Internet.user_name
      name  = Faker::Name.name
      email = Faker::Internet.email
      password  = "password"
      openid_identifier = ""
      User.create!(:username => username + "_usr",
                   :name => name,
                   :email => email,
                   :password => password,
                   :password_confirmation => password,
                   :openid_identifier => openid_identifier)
    end
  end
end

