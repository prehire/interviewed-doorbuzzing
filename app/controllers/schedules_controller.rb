class SchedulesController < ApplicationController
  before_filter :authenticate_user!

  before_action :set_schedule, only: [:show, :update, :destroy]

  # GET /schedules
  # GET /schedules.json
  def index
    @schedules = current_user.schedules.order(:day_of_week, :start_time)
  end

  # GET /schedules/1
  # GET /schedules/1.json
  def show
  end

  # GET /schedules/new
  def new
    @schedule = current_user.schedules.new
  end

  # POST /schedules
  # POST /schedules.json
  def create
    @schedule = current_user.schedules.new(schedule_params)
    if @schedule.save
      redirect_to schedules_path, notice: 'Schedule was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /schedules/1
  # PATCH/PUT /schedules/1.json
  def update
    if @schedule.update(schedule_params)
      redirect_to schedules_path, notice: 'Schedule was successfully updated.'
    else
      render :show
    end
  end

  # DELETE /schedules/1
  # DELETE /schedules/1.json
  def destroy
    @schedule.destroy
    redirect_to schedules_url, notice: 'Schedule was successfully destroyed.'
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_schedule
    @schedule = current_user.schedules.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def schedule_params
    params.require(:schedule).permit(
      :start_time,
      :end_time,
      :day_of_week
    )
  end
end
