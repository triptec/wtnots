class UserSession < Authlogic::Session::Base
	login_field :username
end
