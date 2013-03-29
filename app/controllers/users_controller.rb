class UsersController < ApplicationController
  # GET /users
  # GET /users.json

  skip_before_filter :logged_in?, :only => [:new, :create]
  skip_before_filter :set_user, :only => [:new, :create]

  def show
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @user }
    end
  end

  def new
    @user = User.new

    respond_to do |format|
      format.html
      format.json { render json: @user }
    end
  end

  def edit
    # Nothing to see here
  end

  def create
    @user = User.new(params[:user])

    respond_to do |format|
      if @user.save
        format.html {
          session[:user_email] = @user.email
          redirect_to :root, notice: 'User was successfully created.'
        }
        format.json { render json: @user, status: :created, location: @user }
      else
        format.html { render action: "new" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @user.update_attributes(params[:user])
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @user.destroy

    respond_to do |format|
      format.html { redirect_to users_url }
      format.json { head :no_content }
    end
  end
end
