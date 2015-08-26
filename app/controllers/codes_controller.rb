class CodesController < ApplicationController
  before_filter :authenticate_user!

  before_action :set_code, only: [:show, :update, :destroy]

  # GET /codes
  # GET /codes.json
  def index
    @codes = current_user.codes
  end

  # GET /codes/1
  # GET /codes/1.json
  def show
  end

  # GET /codes/new
  def new
    @code = current_user.codes.new
  end

  # POST /codes
  # POST /codes.json
  def create
    @code = current_user.codes.new(code_params)
    if @code.save
      redirect_to codes_path, notice: 'Code was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /codes/1
  # PATCH/PUT /codes/1.json
  def update
    if @code.update(code_params)
      redirect_to codes_path, notice: 'Code was successfully updated.'
    else
      render :show
    end
  end

  # DELETE /codes/1
  # DELETE /codes/1.json
  def destroy
    @code.destroy
    redirect_to codes_url, notice: 'Code was successfully destroyed.'
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_code
    @code = current_user.codes.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def code_params
    params.require(:code).permit(
      :name,
      :pin
    )
  end
end
