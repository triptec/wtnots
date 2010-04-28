require 'spec_helper'

describe SongsController do
  integrate_views
  before(:each) do
    @base_title = "What's the name of the song?"
  end

  describe "GET index" do
    describe "when not signed in" do
      it "should have the right title" do
        get :index
        response.should have_tag("title", @base_title + " | Songs")
      end
    end

  
  end
end
