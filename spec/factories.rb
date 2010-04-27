Factory.define :user do |user|
  user.username               "usern"
  user.name                   "UserFirstn UserLastn"
  user.email                  "usern@gmail.com"
  user.password               "passwordn"
  user.password_confirmation  "passwordn"
  user.openid_identifier      "https://www.google.com/accounts/o8/id?id=n"
  user.admin                  false
end

Factory.sequence :username do |n|
  "user#{n}"
end

Factory.sequence :email do |n|
  "user#{n}@example.com"
end

Factory.sequence :openid_identifier do |n|
  "https://www.google.com/accounts/o8/id?id=#{n}" 
end
