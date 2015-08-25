class DestinationsController < ApplicationController

  before_filter :authenticate_user!
  
  before_action :set_destination, only: [:show, :update, :destroy]

  # GET /destinations
  # GET /destinations.json
  def index
    @destinations = current_user.destinations
  end

  # GET /destinations/1
  # GET /destinations/1.json
  def show
  end

  # GET /destinations/new
  def new
    @destination = current_user.destinations.new
  end

  # POST /destinations
  # POST /destinations.json
  def create
    @destination = current_user.destinations.new(destination_params)
    if @destination.save
      redirect_to destinations_path, notice: 'Destination was successfully created.' 
    else
      render :new 
    end
  end

  # PATCH/PUT /destinations/1
  # PATCH/PUT /destinations/1.json
  def update
    if @destination.update(destination_params)
      redirect_to destinations_path, notice: 'Destination was successfully updated.' 
    else
      render :show 
    end
  end

  # DELETE /destinations/1
  # DELETE /destinations/1.json
  def destroy
    @destination.destroy
    redirect_to destinations_url, notice: 'Destination was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_destination
      @destination = current_user.destinations.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def destination_params
      params.require(:destination).permit(
        :name,
        :phone,
        :sequence,
      )    
    end
end
