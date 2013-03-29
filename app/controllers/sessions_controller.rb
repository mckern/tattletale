# -*- encoding : utf-8 -*-
class SessionsController < ApplicationController
  # No need to filter the session controller
  skip_before_filter :logged_in?

  # Make new session
  def create
    # Does the user exist in the database already?
    @user = User.authenticate(params[:email])
    if @user
      session[:user] = @user
      redirect_to :root and return
    else
      # The user wasn't found; see if they want to sign up
      redirect_to(:signup)
    end
  end

  # Remove the user id from the session
  def destroy
    # Stupid kludge to keep the User tracking table relatively clean;
    #=> Roughly the same function will be performed periodically by `Colin`.
    # if session[:user].exists_in_database?
    #       @user = User.find session[:user].id
    #       @user.destroy if @user.has_no_bundles?
    #     end
    reset_session
    redirect_to :login
  end
  alias :delete :destroy

  def index
    redirect_to :root
  end
end
