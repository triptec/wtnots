class ApplicationController < ActionController::Base
  helper :all
  helper_method :current_user_session, :current_user, :correct_user
  filter_parameter_logging :password, :password_confirmation
  
  private
    def current_user_session
      return @current_user_session if defined?(@current_user_session)
      @current_user_session = UserSession.find
    end
    
    def current_user
      return @current_user if defined?(@current_user)
      @current_user = current_user_session && current_user_session.record
    end
    
    def correct_user(user = User.find(params[:id]))
      return true if current_user && current_user.admin
      return true if current_user == user
      false
    end

    def admin_user
      return @current_user.admin if defined?(@current_user)
      false
    end
    
    def require_user
      unless current_user
        store_location
        flash[:notice] = "You must be logged in to access this page"
        redirect_to new_user_session_url
        return false
      end
    end
    
    def require_specific_user
      unless correct_user || current_user.admin
        store_location
        flash[:notice] = "Action not allowed"
        redirect_to user_path(params[:id])
        #redirect_to new_user_session_url
        return false
      end
    end

    def require_no_user
      if current_user
        store_location
        flash[:notice] = "You must be logged out to access this page"
        redirect_to user_url(current_user)
        return false
      end
    end
    
    def store_location
      session[:return_to] = request.request_uri
    end
    
    def redirect_back_or_default(default)
      redirect_to(session[:return_to] || default)
      session[:return_to] = nil
    end
end
