class JobsController < ApplicationController
  skip_before_filter :logged_in?, :only => :checkin
  skip_before_filter :set_user, :only => :checkin

  def index
    @jobs = @user.jobs.reload

    respond_to do |format|
      # format.html # index.html.erb
      # format.json { render json: @jobs }
      format.json { render json: @jobs }
    end
  end

  # GET /jobs/1
  # GET /jobs/1.json
  def show
    @job = @user.jobs.find_by_id!(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render_for_api :checkins_with_job, :json => @job, :root => :job }
    end
  end

  # GET /jobs/new
  # GET /jobs/new.json
  def new
    @job = @user.jobs.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @job }
    end
  end

  # GET /jobs/1/edit
  def edit
    @job = @user.jobs.find(params[:id])
  end

  # POST /jobs
  # POST /jobs.json
  def create
    @job = @user.jobs.new(job_params)

    respond_to do |format|
      if @job.save
        format.html { redirect_to :dashboard, notice: 'Job was successfully created.' }
        format.json { render json: @job, status: :created, location: @job }
      else
        format.html { render action: "new" }
        format.json { render json: @job.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /jobs/1
  # PUT /jobs/1.json
  def update
    @job = @user.jobs.find(params[:id])

    respond_to do |format|
      if @job.update(job_params)
        format.html { redirect_to @job, notice: 'Job was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @job.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /jobs/1
  # DELETE /jobs/1.json
  def destroy
    @job = @user.jobs.find(params[:id])
    @job.destroy

    respond_to do |format|
      format.html { redirect_to :dashboard, notice: 'Job was successfully deleted.' }
      format.json { head :no_content }
    end
  end

  def toggle
    @job = @user.jobs.find_by_id!(params[:id])
    @job.toggle 'active'

    respond_to do |format|
      if @job.update(active: @job.active)
        format.html { redirect_to request.referer, notice: 'Job was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @job.errors, status: :unprocessable_entity }
      end
    end
  end

  def checkin
    begin
      @job = Job.find_by_url!(params[:url])
      @job.checkins << Checkin.new unless @job.paused?
    rescue
      redirect_to :root, :alert => @job.errors and return
    end

    respond_to do |format|
      format.html { head :ok }
    end
  end

  def job_params
    params.require(:job).permit(:active, :description, :name, :cron_string, :url)
  end
  private :job_params
end
