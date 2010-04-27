require 'spec_helper'

describe "Layout links" do
  describe "when not signed in" do
    before(:each) do
      @user = Factory(:user)
    end
    it "should have a Login page at '/'" do
      get '/'
      response.should render_template('songs/index')
    end

    it "should show users page at '/users'" do
      get '/users'
      response.should render_template('users/index')
    end

    it "should show songs  page at '/songs" do
      get '/songs'
      response.should render_template('songs/index')
    end

    it "should have the right links on the layout" do
      visit root_path
      click_link "Home"
      response.should render_template('songs/index')
      click_link "Register"
      response.should render_template('users/new')
      click_link "Sign in"
      response.should render_template('user_sessions/new')
    end
  end

  describe "when signed in" do
    before(:each) do
      @user = Factory(:user)
      activate_authlogic
      UserSession.create @user
    end
    it "should have a Login page at '/'" do
      get '/'
      response.should render_template('songs/index')
    end

    it "should show users page at '/users'" do
      get '/users'
      response.should render_template('users/index')
    end

    it "should show songs  page at '/songs" do
      get '/songs'
      response.should render_template('songs/index')
    end

    it "should have the right links on the layout" do
      visit signin_path
      fill_in "Username", :with => "usern"
      fill_in "Password", :with => "passwordn"
      click_button "Login"
      click_link "Home"
      response.should render_template('songs/index')
      click_link "Active Users", :id => "active_users"
      response.should render_template('user_sessions/index')
      click_link "Users"
      response.should render_template('users/index')
      click_link "Profile"
      response.should render_template('users/show')
      click_link "Logout"
      flash[:notice].should == "Logout successful!"
      visit user_path(@user)
      flash[:notice].should == "You must be logged in to access this page"
      response.should render_template('user_sessions/new')
    end
  end

end

