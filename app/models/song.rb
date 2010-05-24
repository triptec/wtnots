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

class Song < ActiveRecord::Base
	has_many :comments
	belongs_to :user, :validate => true


  validates_presence_of :user_id, :title, :description
  validates_length_of :title, :within => 5..255 
  validates_length_of :description, :minimum => 20 
  has_attached_file :audio
end
