class LocationsController < ApplicationController
  before_action :authenticate_user!

  def index
    @locations = current_user.locations
  end

  def new
    @location = current_user.locations.build
  end

  def create
    @location_name = params[:location][:name]
    coordinates = geocode_location(@location_name)
  
    if coordinates
      forecast_data = get_forecast_for(coordinates)
      if forecast_data
        @location = current_user.locations.create(
          name: @location_name,
          forecast: forecast_data
        )
  
        if @location.persisted?
          respond_to do |format|
            format.turbo_stream do
              render turbo_stream: turbo_stream.append("locations", partial: "locations/location", locals: { location: @location })
            end
            format.html { redirect_to root_path, notice: 'Location was successfully created.' }
          end
        else
          error_messages = @location.errors.full_messages.to_sentence
          handle_error(error_messages, target: 'form_errors')
        end
      else
        handle_error("Forecast data could not be retrieved. Please try again.", target: 'forecast_errors')
      end      
    else
      handle_error("Location could not be geocoded. Please check the location name and try again.", target: 'geocode_errors')
    end    
  end

  def destroy
    @location = current_user.locations.find(params[:id])
    @location.destroy
    
    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: turbo_stream.remove("location-#{params[:id]}")
      end
      format.html { redirect_to root_path, notice: 'Location was successfully destroyed.' }
    end
  end  

  private

  def geocode_location(location_name)
    response = HTTParty.get("https://geocoding-api.open-meteo.com/v1/search", query: { name: location_name, count: 1 })
      
    if response.success?
      json = JSON.parse(response.body)
      if json["results"].present?
        latitude = json["results"].first["latitude"]
        longitude = json["results"].first["longitude"]
        { lat: latitude, lon: longitude }
      else
        Rails.logger.info "No geocoding results found for #{location_name}"
        nil
      end
    else
      Rails.logger.error "Geocoding API error: #{response.body}"
      nil
    end
  rescue => e
    Rails.logger.error "Geocoding API request failed: #{e.message}"
    nil
  end
   

  def get_forecast_for(coordinates)
    response = HTTParty.get("https://api.open-meteo.com/v1/forecast", query: {
      latitude: coordinates[:lat],
      longitude: coordinates[:lon],
      daily: "temperature_2m_max,temperature_2m_min,weathercode",
      timezone: "auto"
    })
      
    if response.success?
      JSON.parse(response.body)
    else
      Rails.logger.error "Weather API error: #{response.body}"
      nil
    end
  rescue => e
    Rails.logger.error "Weather API request failed: #{e.message}"
    nil
  end

  def handle_error(message, target: 'form_errors')
    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: turbo_stream.replace(target, partial: "shared/errors", locals: { message: message })
      end
      format.html do
        flash[:alert] = message
        redirect_to root_path
      end
    end
  end
end
