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
                 :admin => true,
                 :openid_identifier => "")
    99.times do |n|
      username = Faker::Internet.user_name
      name  = Faker::Name.name
      email = Faker::Internet.email
      password  = "password"
      openid_identifier = ""
      user = User.create!(:username => username + "_usr",
                   :name => name,
                   :email => email,
                   :password => password,
                   :password_confirmation => password,
                   :openid_identifier => openid_identifier)
      4.times do |m|
        title = Faker::Lorem.words(5).join(" ")
        description = Faker::Lorem.paragraphs(2).join
        user_id = user.id
        Song.create!(:title => title,
                     :description => description,
                     :user_id => user_id)
      end
    end
  end
end
