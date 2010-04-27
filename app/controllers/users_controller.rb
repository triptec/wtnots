class UsersController < ApplicationController
  before_filter :require_no_user, :only => [:new, :create]
  before_filter :require_user, :only => [:show, :edit, :update]
  before_filter :admin_user,   :only => :destroy

	def index
		@title = "All Users"
    @users = User.paginate(:page => params[:page])
	end
  
  def new
		@title = "Register"
    @user = User.new
  end
  
  def create
    @user = User.new(params[:user])
    @user.save do |result|
      if result
        flash[:notice] = "Account registered!"
        redirect_back_or_default user_url(@user.id)
      else
        render :action => :new
      end
    end
  end
  
  def show
    @user = User.find(params[:id])
		@title = "Profile: " + @user.username 
  end

  def edit
    @user = @current_user
		@title = "Edit Profile: " + @user.username
  end
  
  def update
    @user = @current_user # makes our views "cleaner" and more consistent
    @user.attributes = params[:user]
    @user.save do |result|
      if result
        flash[:notice] = "Account updated!"
        redirect_to user_url(current_user)
      else
        render :action => :edit
      end
    end
  end

  def destroy
    user = User.find(params[:id]).destroy
    flash[:success] = "User destroyed."
    redirect_to users_path
  end
end
