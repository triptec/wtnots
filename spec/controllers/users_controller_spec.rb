require 'spec_helper'
require 'authlogic/test_case'

describe UsersController do
	integrate_views
	
  before(:each) do
		@base_title = "What's the name of the song?"
  end
	

  describe "GET 'index'" do
    describe "when not signed in" do
      it "should be successful" do
        get :index
        response.should be_success
      end

      it "should have the right title" do
        get :index
        response.should have_tag("title", @base_title + " | All Users")
      end
    end
    describe "when signed in" do
      before(:each) do
        @user = Factory(:user)
        @otheruser = Factory(:user, :username => Factory.next(:username), :email => Factory.next(:email))
        activate_authlogic
        UserSession.create @user
      end
      it "should be successful" do
        get :index
        response.should be_success
      end

      it "should have the right title" do
        get :index
        response.should have_tag("title", @base_title + " | All Users")
      end
      it "should have the delete option on self" do
        get :index
        response.should have_tag("a[href=?]",user_path(@user), :text => "delete")
      end
      it "should not have the delete option on others" do
        get :index
        response.should_not have_tag("a[href=?]",user_path(@otheruser), :text => "delete")
      end

    end

    describe "when signed in as admin" do
      before(:each) do
        @user = Factory(:user,:admin => true)
        @otheruser = Factory(:user, :username => Factory.next(:username), :email => Factory.next(:email))
        activate_authlogic
        UserSession.create @user
      end
      it "should be successful" do
        get :index
        response.should be_success
      end

      it "should have the delete option on all" do
        get :index
        response.should have_tag("a[href=?]",user_path(@user), :text => "delete")
        response.should have_tag("a[href=?]",user_path(@otheruser), :text => "delete")
      end

    end
  end

  describe "GET 'new'" do
    describe "when not signed in" do
      before(:each) do
        @user = Factory(:user)
        User.stub!(:find, @user.id).and_return(@user)
      end
      it "should be successful" do
        get 'new'
        response.should be_success
      end
      it "should have the right title" do
        get "new"
        response.should have_tag("title", @base_title + " | Register")
      end

      it "should have no notice" do
        get "new"
        flash[:notice].should  == nil
      end
    end

    describe "when signed in" do

      before(:each) do
        @user = Factory(:user)
        User.stub!(:find, @user.id).and_return(@user)
        activate_authlogic
        UserSession.create @user
      end
    
      it "should not be successful" do
        get 'new'
        response.should_not be_success
      end

      it "should redirect" do
        get 'new'
        response.should redirect_to user_path(@user)
      end

      it "should have the right notice" do
        get "new"
        flash[:notice].should  == "You must be logged out to access this page"
      end
    end
  end

	describe "GET 'show'" do
    describe "when not signed in" do
      before(:each) do
        @user = Factory(:user)
        User.stub!(:find, @user.id).and_return(@user)
      end

      it "should not be successful" do
		    get :show, :id => @user
        response.should redirect_to(new_user_session_url)
      end
    end
		
    it "should have the right notice" do
			get :show, :id => @user
      response.should redirect_to(new_user_session_url)
			flash[:notice].should == "You must be logged in to access this page"
		end
    
    describe "when signed in" do
      before(:each) do
        @user = Factory(:user)
        User.stub!(:find, @user.id).and_return(@user)
        activate_authlogic
        UserSession.create @user
      end
    
      it "should have the right title" do
        get :show, :id => @user
        response.should have_tag("title", /What's the name of the song? | Profile: #{@user.username}/)
      end

      it "should include the user's name" do
        get :show, :id => @user
        response.should have_tag("h2", /#{@user.name}/)
      end

      it "should have a profile image" do
        get :show, :id => @user
        response.should have_tag("img", :class => "gravatar")
      end
    end
	end

  describe "GET 'edit'" do

    describe "when not signed in" do
      before(:each) do
#        @user = Factory(:user)
#        User.stub!(:find, @user.id).and_return(@user)
      end

      it "should be not be successful" do
		    get :edit, :id => @user
	      response.should_not be_success
        response.should redirect_to(new_user_session_url)
	    end
    end

    describe "when signed in" do
      before(:each) do
        @user = Factory(:user)
        User.stub!(:find, @user.id).and_return(@user)
        activate_authlogic
        UserSession.create @user
      end

      it "should be successful" do
        get :edit, :id => @user
        response.should be_success
      end

      it "should have the right title" do
        get :edit, :id => @user
        response.should have_tag("title", /Edit Profile: #{@user.username}/i)
      end

      it "should have a link to change the Gravatar" do
        get :edit, :id => @user
        gravatar_url = "http://gravatar.com/emails"
        response.should have_tag("a[href=?]", gravatar_url, /change/i)
      end
    end
  end

  #  #These tests will fail due to bug in authlogic-oid
#  describe "POST 'create'" do
#
#    describe "failure" do
#
#      before(:each) do
#        @attr = { :username => "",:name => "", :email => "", :password => "",
#                  :password_confirmation => "", :openid_identifier => "" }
#        @user = Factory.build(:user, @attr)
#        User.stub!(:new).and_return(@user)
#        @user.should_receive(:save).and_return(false)
#      end
#
#      it "should have the right title" do
#        post :create, :user => @attr
#        response.should have_tag("title", /register/i)
#      end
#
#      it "should render the 'new' page" do
#        post :create, :user => @attr
#        response.should render_template('new')
#      end
#    end
#
#    describe "success" do
#
#      before(:each) do
#        @attr = { :username => "triptec",:name => "Andreas Franzén", :email => "triptec@gmail.com", :password => "foobar",
#                  :password_confirmation => "foobar", :openid_identifier => "" }
#        @user = Factory(:user, @attr)
#        User.stub!(:new).and_return(@user)
#        @user.should_receive(:save).and_return(true)
#      end
#
#      it "should redirect to the user show page" do
#        post :create, :user => @attr
#        response.should redirect_to user_url
#      end    
#    end
#  end
end

