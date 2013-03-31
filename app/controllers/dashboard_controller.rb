class DashboardController < ApplicationController

  def index
    @jobs = @user.jobs.reload

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @jobs }
    end
  end

end
