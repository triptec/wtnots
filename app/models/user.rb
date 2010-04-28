# == Schema Information
# Schema version: 20100424102356
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
#  admin               :boolean         not null
#  openid_identifier   :string(255)
#

class User < ActiveRecord::Base
  has_many :songs
  has_many :comments
	acts_as_authentic do |c|

	c.validates_length_of_login_field_options :within => 5..50
	c.validates_format_of_login_field_options
	c.validates_uniqueness_of_login_field_options
	
	c.validates_length_of_email_field_options
	c.validates_format_of_email_field_options
	c.validates_uniqueness_of_email_field_options

  c.openid_required_fields = :email
  
  c.validates_length_of_password_field_options :within => 5..50
	c.require_password_confirmation
  c.ignore_blank_passwords false
	c.validates_presence_of	:name
	c.validates_length_of		:name, :within => 5..50
	end

#  cattr_reader :per_page
#  @@per_page = 10

  private
    def map_openid_registration(registration)
      self.email = registration["email"] if email.blank?
      #self.username = registration["nickname"] if nickname.blank?
    end
end
