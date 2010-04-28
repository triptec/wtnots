# == Schema Information
# Schema version: 20100424102356
#
# Table name: songs
#
#  id          :integer         not null, primary key
#  title       :string(255)
#  description :text
#  user_id     :integer
#  created_at  :datetime
#  updated_at  :datetime
#

require 'spec_helper'

describe Song do
  describe "create" do
      before(:each) do
        @valid_attributes = {:title => "Test title", :description => "This is the description it's supposed to be atleast 20 chars, I guess I'm there...", :user_id => 1 }
        @invalid_attributes = {:title => "", :description => "", :user_id => nil }
      end
    describe "with valid attributes" do

      it "should create a new instance" do
        @song = Song.create!(@valid_attributes)
        @song.should be_valid
      end
    end

    describe "with invalid attributes" do

      it "should not create a new instance with all blank" do
        @invalid_song = Song.new(@invalid_attributes)
        @invalid_song.should_not be_valid
        @invalid_song.errors.on(:user_id).should == "can't be blank"
        @invalid_song.errors.on(:title).should == ["can't be blank","is too short (minimum is 5 characters)"]
        @invalid_song.errors.on(:description).should == ["can't be blank","is too short (minimum is 20 characters)"]
      end

      it "should not create a new instance with :user_id blank" do
        @invalid_song = Song.new(@valid_attributes.merge(:user_id => ""))
        @invalid_song.should_not be_valid
        @invalid_song.errors.on(:user_id).should == "can't be blank"
        @invalid_song.errors.on(:title).should == nil
        @invalid_song.errors.on(:description).should == nil
      end
      it "should not create a new instance with :title blank" do
        @invalid_song = Song.new(@valid_attributes.merge(:title => ""))
        @invalid_song.should_not be_valid
        @invalid_song.errors.on(:title).should == ["can't be blank","is too short (minimum is 5 characters)"]
        @invalid_song.errors.on(:user_id).should == nil
        @invalid_song.errors.on(:description).should == nil
      end
      it "should not create a new instance with :description blank" do
        @invalid_song = Song.new(@valid_attributes.merge(:description => ""))
        @invalid_song.should_not be_valid
        @invalid_song.errors.on(:description).should == ["can't be blank","is too short (minimum is 20 characters)"]
        @invalid_song.errors.on(:user_id).should == nil
        @invalid_song.errors.on(:title).should == nil
      end

    end
  end
end
