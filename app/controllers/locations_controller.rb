class LocationsController < ApplicationController
  class LocationsController < ApplicationController
    before_action :set_location, only: [:show, :edit, :update, :destroy]
    before_action :authenticate_user!, except: [:index, :show]
  
    def index
      @locations = Location.all
    end
  
    def show
    end
  
    def new
      @location = current_user.locations.build
    end
  
    def create
      @location = current_user.locations.build(location_params)
      if @location.save
        redirect_to @location, notice: 'Location was successfully created.'
      else
        render :new
      end
    end
  
    def edit
    end
  
    def update
      if @location.update(location_params)
        redirect_to @location, notice: 'Location was successfully updated.'
      else
        render :edit
      end
    end
  
    def destroy
      @location.destroy
      redirect_to locations_url, notice: 'Location was successfully destroyed.'
    end
  
    private
      def set_location
        @location = Location.find(params[:id])
      end
  
      def location_params
        params.require(:location).permit(:name, :latitude, :longitude)
      end
  end
  
end
