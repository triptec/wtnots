# == Schema Information
# Schema version: 20100422191418
#
# Table name: users
#
#  id                  :integer         not null, primary key
#  username            :string(255)
#  name                :string(255)
#  email               :string(255)
#  crypted_password    :string(255)
#  password_salt       :string(255)
#  persistence_token   :string(255)     not null
#  single_access_token :string(255)     not null
#  perishable_token    :string(255)     not null
#  login_count         :integer         default(0), not null
#  failed_login_count  :integer         default(0), not null
#  last_request_at     :datetime
#  current_login_at    :datetime
#  last_login_at       :datetime
#  current_login_ip    :string(255)
#  last_login_ip       :string(255)
#  created_at          :datetime
#  updated_at          :datetime
#  admin               :boolean
#

class User < ActiveRecord::Base
	acts_as_authentic do |c|

	EmailRegex = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
	c.validates_length_of_login_field_options :within => 5..50
	c.validates_format_of_login_field_options
	c.validates_uniqueness_of_login_field_options
	
	c.validates_length_of_email_field_options
	c.validates_format_of_email_field_options
	c.validates_uniqueness_of_email_field_options
	
	c.require_password_confirmation

	c.validates_presence_of	:name
	c.validates_length_of		:name, :within => 5..50
	end
end
