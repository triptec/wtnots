require 'spec_helper'
describe User do

  before(:each) do
    @attr = { :username => "example", :name => "Example User", :email => "user@example.com", :password => "example", :password_confirmation => "example"}
  end

  it "should create a new instance given valid attributes" do
    User.create!(@attr)
  end

  it "should require a name" do
    no_name_user = User.new(@attr.merge(:name => ""))
    no_name_user.should_not be_valid
		no_name_user.errors.on(:name).should == "can't be blank"
  end

  it "should require an email address" do
    no_email_user = User.new(@attr.merge(:email => ""))
    no_email_user.should_not be_valid
		no_email_user.errors.on(:email).should == ["is too short (minimum is 6 characters)", "should look like an email address.", "can't be blank", "is invalid"]
  end

  it "should reject names that are too long" do
    long_name = "a" * 51
    long_name_user = User.new(@attr.merge(:name => long_name))
    long_name_user.should_not be_valid
		long_name_user.errors.on(:name).should == "is too long (maximum is 50 characters)"
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
			invalid_email_user.errors.on(:email).should == ["should look like an email address.", "is invalid"]
    end
  end

  it "should reject duplicate email addresses" do
    # Put a user with given email address into the database.
    User.create!(@attr)
    user_with_duplicate_email = User.new(@attr)
    user_with_duplicate_email.should_not be_valid
		user_with_duplicate_email.errors.on(:email).should ==  ["has already been taken", "has already been taken"]
  end

  it "should reject email addresses identical up to case" do
    upcased_email = @attr[:email].upcase
    User.create!(@attr.merge(:email => upcased_email))
    user_with_duplicate_email = User.new(@attr)
    user_with_duplicate_email.should_not be_valid
		user_with_duplicate_email.errors.on(:email).should ==  ["has already been taken", "has already been taken"]
  end




end

