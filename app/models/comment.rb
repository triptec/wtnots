class Comment < ActiveRecord::Base
	belongs_to :song
	has_many :replyships
	has_many :replies, :through => :replyships
	has_many :inverse_replyships, :class_name => "Replyship", :foreign_key => "reply_id"
	has_many :inverse_replies, :through => :inverse_replyships, :source => :comment
end
