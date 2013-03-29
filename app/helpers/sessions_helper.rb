module SessionsHelper

  def log_in(user)
    cookies.permanent[:remember_token] = user.remember_token #expires 20yrs from now
    self.current_user = user
  end

  def logged_in?
    !current_user.nil?
  end

  def current_user=(user)
    @current_user = user
  end

  def current_user
    @current_user ||= User.find_by_remember_token(cookies[:remember_token])
  end

  def current_user?(user)
    user == current_user
  end

  def logged_in_user
    unless logged_in?
      store_location
      redirect_to login_url, notice: "Please log in."
    end
  end

  def log_out
    current_user = nil
    cookies.delete(:remember_token)
  end

  def redirect_back_or(default)
    redirect_to(session[:return_to] || default) #grabs where they wanted to go from the session cookie if populated
    session.delete(:return_to) #deletes that path
  end

  def store_location
    session[:return_to] = request.url #stores where they wanted to go in the session cookie
  end
end