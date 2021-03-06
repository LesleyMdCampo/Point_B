class StarsController < ApplicationController

  def index
    @user = current_user
    @stars = @user.stars
    if @stars
      @destinations = @stars.map {|s| s.destination}
      @lat_lngs = @destinations.map {|d| d.lat_lng}
    end
  end

  def show
  end

  def new
  end

  def create
    @destination = Destination.find(params[:destination_id])
    user = current_user
    if user.stars.where(destination_id: @destination.id).count == 0
      @star = Star.new(star_params)
      @star.user_id = user.id
      @star.destination_id = @destination.id
      respond_to do |format|
        if @star.save
          format.html { redirect_to user_destination_path user, @destination }
          format.js { render layout: false }
          format.json { head :no_content }
        else
          format.html { redirect_to user_destination_path user, destination, notice: 'Sorry, could not star destination' }
        end
      end
    end
  end

  def edit
  end

  def update
    @star = Star.find(params[:id])
    respond_to do |format|
      if @star.update(star_params)
        format.html { redirect_to stars_path }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @star.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @star = Star.find(params[:id])
    @star.destroy
    respond_to do |format|
      format.html { redirect_to stars_path }
      format.json { head :no_content }
    end
  end

  private

  def star_params
      params.permit(:user_id, :destination_id)
    end
end
