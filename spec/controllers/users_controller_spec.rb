require 'spec_helper'

describe UsersController do
	integrate_views

	before(:each) do
		@base_title = "What's the name of the song?"
	end
	
  30.times {Factory(:user, :username => Factory.next(:username), :email => Factory.next(:email),:openid_identifier => "")}

	describe "GET 'index'" do
		it "should be successful" do
			get 'index'
			response.should be_success
		end
		it "should have the right title" do
			get "index"
			response.should have_tag("title", @base_title + " | All Users")
		end
	end

	describe "GET 'new'" do
		it "should be successful" do
			get 'new'
			response.should be_success
		end
		it "should have the right title" do
			get "new"
			response.should have_tag("title", @base_title + " | Register")
		end
	end

	describe "GET 'show'" do
    it "should not be successful" do
			get 'show', :id => @user
			response.should_not be_success
      response.should redirect_to(new_user_session_url)
		end
	end

	describe "GET 'edit'" do
    it "should be not be successful" do
			get 'edit', :id => @user
			response.should_not be_success
      response.should redirect_to(new_user_session_url)
		end
	end
end

