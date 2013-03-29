class UsersController < ApplicationController
  #NEED TO REFACTOR TO REMOVE INDEX
  before_filter :logged_in_user, 
                only: [:index, :edit, :update, :destroy]
  before_filter :correct_user,   only: [:edit, :update]
  before_filter :admin_user,     only: [:destroy]

  def show
  	@user= User.find(params[:id]) #show the user with the Id in the param. Doesn't seem very secure...
  end
  
  def new
  	@user=User.new
  end

  def create
  	@user=User.new(params[:user])
  	if @user.save
		  log_in @user #from sessions_helper
      flash[:success] = "Welcome to the RSU Helper App!"
		  redirect_to @user
  	else
  		render 'new'
  	end
  end

  def edit
    #@user=User.find(params[:id]) #not needed given correct_user method below run in before_filter
  end #edit

  def update
    #@user = User.find(params[:id]) #not needed given correct_user method below run in before_filter
    if @user.update_attributes(params[:user])
      flash[:success] = "Profile updated"
      log_in @user #from sessions_helper
      redirect_to @user    
    else
      render 'edit'
    end
  end #update

  def index
    @users = User.paginate(page: params[:page])
  end #index

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User deleted."
    redirect_to users_url
  end

  private

    def logged_in_user
      unless logged_in? #if not logged in
        store_location #session_helper -store where they wanted to go in the session cookie
        redirect_to login_url, notice: "Please log in." unless logged_in? #then redirect to the login page
      end
    end

    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_path) unless current_user?(@user)
    end

    def admin_user
      redirect_to(root_path) unless current_user.admin?
    end
end