# frozen_string_literal: true

class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :logged_in?, except: %i[login signup]
  before_filter :set_user, except: %i[login signup]

  def new; end

  def create; end

  protected

  def logged_in?
    if session[:user_email]
      unless User.find_by_email(session[:user_email])
        logger.debug "Redirecting to /login because #{session[:user_email]} was not found"
        reset_session
        redirect_to(:login)
      end
    else
      logger.debug "Redirecting to /login because no session data was found"
      redirect_to(:login)
    end
  end

  def set_user
    @user = User.find_by_email session[:user_email]
  end

  alias std_redirect_to redirect_to
  def redirect_to(*args)
    flash.keep
    std_redirect_to *args
  end
end
