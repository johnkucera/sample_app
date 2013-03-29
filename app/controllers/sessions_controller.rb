class SessionsController < ApplicationController

  def new
  end

  def create
    user = User.find_by_email(params[:session][:email].downcase)
	  if user && user.authenticate(params[:session][:password])
      log_in user #from sessions_helper
      redirect_back_or user
    else
      flash.now[:error] = 'Invalid email/password combination'
      render 'new'
    end
  end

  def destroy
    log_out  #from sessions_helper
    redirect_to root_url
  end
end