# -*- encoding : utf-8 -*-
class SessionsController < ApplicationController
  # No need to filter the session controller
  skip_before_filter :logged_in?
  skip_before_filter :set_user

  # Make new session
  def create
    # Does the user exist in the database already?
    @user = User.authenticate(params[:email])

    if @user
      session[:user_email] = @user.email
      redirect_to :root and return
    else
      # The user wasn't found; see if they want to sign up
      redirect_to(:signup)
    end
  end

  # Remove the user id from the session
  def destroy
    reset_session
    redirect_to :login
  end
  alias :delete :destroy

  def index
    # redirect_to :root
  end
end
