require 'spec_helper'

describe "Layout links" do
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

