# == Schema Information
# Schema version: 20100424102356
#
# Table name: replyships
#
#  id         :integer         not null, primary key
#  comment_id :integer
#  reply_id   :integer
#  created_at :datetime
#  updated_at :datetime
#

class Replyship < ActiveRecord::Base
	belongs_to :comment
	belongs_to :reply, :class_name => "Comment"
end
