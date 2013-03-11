class UsersController < ApplicationController
  def show
  	@user= User.find(params[:id]) #show the user with the Id in the param. Doesn't seem very secure...
  end
  def new
  	@user=User.new
  end

  def create
  	@user=User.new(params[:user])
  	if @user.save
		flash[:success] = "Welcome to the Sample App!"
		redirect_to @user
  	else
  		render 'new'
  	end
  end
end