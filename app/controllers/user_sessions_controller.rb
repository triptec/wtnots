class UserSessionsController < ApplicationController
  before_filter :require_no_user, :only => [:new, :create]
  before_filter :require_user, :only => :destroy
  add_crumb ("Active Users") {|instance| instance.send :active_users_path} 
  def index
    @user_sessions = User.paginate(:page => params[:page], :conditions => ["last_request_at > ?", 30.minutes.ago])
    #@user_sessions = User.paginate(:page => params[:page])
  end

  def new
    @user_session = UserSession.new
  end
  
  def create
    @user_session = UserSession.new(params[:user_session])
    @user_session.save do |result|
      if result
        flash[:notice] = "Login successful!"
        redirect_back_or_default user_url(@user_session.user)
      else
        flash[:notice] = "Login failed"
        render :action => :new
      end
    end
  end
  
  def destroy
    current_user_session.destroy
    flash[:notice] = "Logout successful!"
    redirect_back_or_default new_user_session_url
  end
end
