class DestinationsController < ApplicationController
  before_action :set_destination, only: [:show, :edit, :update, :destroy]

  # GET /trips
  # GET /trips.json
  def index
    @destinations = Destination.all
  end

  # GET /destinations/1
  # GET /destinations/1.json
  def show
    @user = User.find(params[:user_id])
  end

  # GET /destinations/new
  def new
    @destination = Destination.new
    @user = User.find(params[:user_id])
  end

  # GET /destinations/1/edit
  def edit
  end

  # POST /destinations
  # POST /destinations.json
  def create
    @destination = Destination.new(destination_params)
    @destination.user_id = params[:user_id]
    if @destination.save
      redirect_to @destination
    else
      redirect_to root_path
    end
  end

  # PATCH/PUT /destinations/1
  # PATCH/PUT /destinations/1.json
  def update
    @user = User.find(params[:user_id])
    respond_to do |format|
      if @destination.update(destination_params)
        format.html { redirect_to user_destination_path(@user.id, @destination.id), notice: 'destination was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @destination.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /destinations/1
  # DELETE /destinations/1.json
  def destroy
    @destination.destroy
    respond_to do |format|
      format.html { redirect_to destinations_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_destination
      @destination = Destination.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def destination_params
      params.require(:destination).permit(:city, :country, :description, :album, :category, :user_id)
    end
end
