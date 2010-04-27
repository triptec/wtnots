# == Schema Information
# Schema version: 20100424102356
#
# Table name: users
#
#  id                  :integer         not null, primary key
#  username            :string(255)
#  name                :string(255)
#  email               :string(255)
#  crypted_password    :string(255)
#  password_salt       :string(255)
#  persistence_token   :string(255)     not null
#  single_access_token :string(255)     not null
#  perishable_token    :string(255)     not null
#  login_count         :integer         default(0), not null
#  failed_login_count  :integer         default(0), not null
#  last_request_at     :datetime
#  current_login_at    :datetime
#  last_login_at       :datetime
#  current_login_ip    :string(255)
#  last_login_ip       :string(255)
#  created_at          :datetime
#  updated_at          :datetime
#  admin               :boolean         not null
#  openid_identifier   :string(255)
#

require 'spec_helper'
describe User do

  before(:each) do
    @attr = { :username => "example", :name => "Example User", :email => "user@example.com", :password => "example", :password_confirmation => "example", :openid_identifier => ""}
  end

  it "should create a new instance given valid attributes" do
    User.create!(@attr)
  end

	#username tests
  
	it "should require a username" do
    no_username_user = User.new(@attr.merge(:username => ""))
    no_username_user.should_not be_valid
		no_username_user.errors.on(:username).should == ["is too short (minimum is 5 characters)", "should use only letters, numbers, spaces, and .-_@ please."]
  end
	
	it "should reject usernames that are too short" do
    short_username_user = User.new(@attr.merge(:username => "aa"))
    short_username_user.should_not be_valid
		short_username_user.errors.on(:username).should == "is too short (minimum is 5 characters)"
  end

  it "should reject usernames that are too long" do
    long_username = "a" * 51
    long_username_user = User.new(@attr.merge(:username => long_username))
    long_username_user.should_not be_valid
		long_username_user.errors.on(:username).should == "is too long (maximum is 50 characters)"
  end
  
  it "should reject duplicate username" do
    User.create!(@attr)
    user_with_duplicate_username = User.new(@attr)
    user_with_duplicate_username.should_not be_valid
		user_with_duplicate_username.errors.on(:username).should ==  "has already been taken"
  end

  it "should reject usernames identical up to case" do
    upcased_email = @attr[:username].upcase
    User.create!(@attr.merge(:username => upcased_email))
    user_with_duplicate_username = User.new(@attr)
    user_with_duplicate_username.should_not be_valid
		user_with_duplicate_username.errors.on(:username).should ==  "has already been taken"
  end

  #password tests
  
	it "should require a password" do
    no_password_user = User.new(@attr.merge(:password => "", :password_confirmation => ""))
    no_password_user.should_not be_valid
		no_password_user.errors.on(:password).should == "is too short (minimum is 5 characters)"
  end
	
  it "should reject short password" do
    short_password_user = User.new(@attr.merge(:password => "aaa", :password_confirmation => "aaa"))
    short_password_user.should_not be_valid
		short_password_user.errors.on(:password).should == "is too short (minimum is 5 characters)"
  end
  
  it "should reject long password" do
    long_password_user = User.new(@attr.merge(:password => "a" * 51, :password_confirmation => "a" * 51))
    long_password_user.should_not be_valid
		long_password_user.errors.on(:password).should == "is too long (maximum is 50 characters)"
  end

  it "should reject password with bad confirmation" do
    bad_confirmation_password_user = User.new(@attr.merge(:password => "aaaaa", :password_confirmation => "AAAAA"))
    bad_confirmation_password_user.should_not be_valid
		bad_confirmation_password_user.errors.on(:password).should == "doesn't match confirmation"
  end

  #password tests with openid

	it "should not require a password" do
    no_password_user = User.new(@attr.merge(:openid_identifier => "http://test.test.com", :password => "", :password_confirmation => ""))
    no_password_user.should be_valid
		no_password_user.errors.on(:password).should == nil 
  end
	
  it "should not reject short password" do
    short_password_user = User.new(@attr.merge(:openid_identifier => "http://test.test.com", :password => "aaa", :password_confirmation => "aaa"))
    short_password_user.should be_valid
		short_password_user.errors.on(:password).should == nil 
  end
  
  it "should not reject long password" do
    long_password_user = User.new(@attr.merge(:openid_identifier => "http://test.test.com", :password => "a" * 51, :password_confirmation => "a" * 51))
    long_password_user.should be_valid
		long_password_user.errors.on(:password).should == nil 
  end

  it "should not reject password with bad confirmation" do
    bad_confirmation_password_user = User.new(@attr.merge(:openid_identifier => "http://test.test.com", :password => "aaaaa", :password_confirmation => "AAAAA"))
    bad_confirmation_password_user.should be_valid
		bad_confirmation_password_user.errors.on(:password).should == nil 
  end
	#name tests	

  it "should require a name" do
    no_name_user = User.new(@attr.merge(:name => ""))
    no_name_user.should_not be_valid
		no_name_user.errors.on(:name).should == ["can't be blank", "is too short (minimum is 5 characters)"]
  end

  it "should reject names that are too long" do
    long_name = "a" * 51
    long_name_user = User.new(@attr.merge(:name => long_name))
    long_name_user.should_not be_valid
		long_name_user.errors.on(:name).should == "is too long (maximum is 50 characters)"
  end

	#email tests

  it "should require an email address" do
    no_email_user = User.new(@attr.merge(:email => ""))
    no_email_user.should_not be_valid
		no_email_user.errors.on(:email).should == ["is too short (minimum is 6 characters)", "should look like an email address."]
  end
  
it "should accept valid email addresses" do
    addresses = %w[user@foo.com THE_USER@foo.bar.org first.last@foo.jp]
    addresses.each do |address|
      valid_email_user = User.new(@attr.merge(:email => address))
      valid_email_user.should be_valid
    end
  end

  it "should reject invalid email addresses" do
    addresses = %w[user@foo,com user_at_foo.org example.user@foo.]
    addresses.each do |address|
      invalid_email_user = User.new(@attr.merge(:email => address))
      invalid_email_user.should_not be_valid
			invalid_email_user.errors.on(:email).should == "should look like an email address."
    end
  end

  it "should reject duplicate email addresses" do
    User.create!(@attr)
    user_with_duplicate_email = User.new(@attr)
    user_with_duplicate_email.should_not be_valid
		user_with_duplicate_email.errors.on(:email).should ==  "has already been taken"
  end

  it "should reject email addresses identical up to case" do
    upcased_email = @attr[:email].upcase
    User.create!(@attr.merge(:email => upcased_email))
    user_with_duplicate_email = User.new(@attr)
    user_with_duplicate_email.should_not be_valid
		user_with_duplicate_email.errors.on(:email).should ==  "has already been taken"
  end




end
