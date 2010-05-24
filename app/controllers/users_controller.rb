class UsersController < ApplicationController
  before_filter :require_no_user, :only => [:new, :create]
  before_filter :require_user, :only => [:show, :edit, :update]
  before_filter :require_specific_user, :only => [:edit, :update]
  before_filter :admin_user,   :only => :destroy
  add_crumb ("Users") {|instance| instance.send :users_path} 
  before_filter :interaction, :only => [:show, :edit]

	def index
		@title = "All Users"
    @users = User.paginate(:page => params[:page], :order => "created_at ASC")
    #@users = User.find(:all)
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
        redirect_back_or_default user_path(@user.id)
      end
    end
    if @user.errors.size != 0 
		  @title = "Register"
      render :action => :new
    end
  end
  
  def show
		@title = "Profile: " + @user.username 
  end

  def edit
		@title = "Edit Profile: " + @user.username
  end
  
  def update
    #@user = @current_user # makes our views "cleaner" and more consistent
    @user = User.find(params[:id])
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
  def interaction
    @user = User.find(params[:id])
    add_crumb @user.username, @user  
  end
end
