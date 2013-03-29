class DashboardController < ApplicationController

  def index
    @services = @user.services.reload

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @services }
    end
  end

end
