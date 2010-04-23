class UserSession < Authlogic::Session::Base
	login_field :username
	logged_in_timeout = 60
	logout_on_timeout = true
end
