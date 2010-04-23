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
	acts_as_authentic

	EmailRegex = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

	validates_presence_of :username, :name, :email
	validates_length_of		:username, :name, :email, :password, :maximum => 50
	validates_format_of   :email, :with => EmailRegex
	validates_uniqueness_of :email, :case_sensitive => false

end
