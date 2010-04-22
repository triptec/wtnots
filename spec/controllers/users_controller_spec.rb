require 'spec_helper'

describe UsersController do
	integrate_views

	before(:each) do
		@base_title = "What's the name of the song?"
	end
	
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

	describe "GET 'edit'" do
		it "should be successful" do
			get 'edit'
			response.should be_success
		end
		it "should have the right title" do
			get "edit"
			response.should have_tag("title", @base_title + " | Edit Profile: ")
		end
	end

	describe "GET 'show'" do
		it "should be successful" do
			get 'show'
			response.should be_success
		end
		it "should have the right title" do
			get "show"
			response.should have_tag("title", @base_title + " | Profile: ")
		end
	end
end

