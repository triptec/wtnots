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
	belongs_to :user
end
