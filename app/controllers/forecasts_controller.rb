class ForecastsController < ApplicationController
  def search
    @location = params[:location]
    if @location.present?
      coordinates = geocode_location(@location)
      @forecast = get_forecast_for(coordinates) if coordinates
    end

    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: turbo_stream.replace("weather", partial: "forecasts/weather", locals: { forecast: @forecast })
      end
      format.html { redirect_to root_path }
    end
  end

  private

  def geocode_location(location)
    # Logic to call the geocoding API and return latitude and longitude
    # Example pseudo-code:
    # response = HTTParty.get("https://api.open-metro.org/geocode?address=#{location}")
    # Parse response to extract latitude and longitude
  end

  def get_forecast_for(coordinates)
    # Logic to call the weather API with the coordinates and return the forecast data
    # Example pseudo-code:
    # response = HTTParty.get("https://api.open-metro.org/weather?lat=#{coordinates[:lat]}&lon=#{coordinates[:lon]}")
    # Parse response to extract and return forecast data
  end
end
