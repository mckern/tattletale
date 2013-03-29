class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :logged_in?

  def new
  end

  def create
  end

  protected

  def logged_in?
    (session[:user] || false) || redirect_to(:login)
  end
end
