# spec/requests/locations_spec.rb
require 'rails_helper'

RSpec.describe "Locations", type: :request do
  describe "POST /locations" do
    let!(:user) { FactoryBot.create(:user) }

    before do
      sign_in user
      
      # Stub for the geocoding API call
      stub_request(:get, "https://geocoding-api.open-meteo.com/v1/search").
        with(query: {"name" => "Berlin", "count" => "1"}).
        to_return(status: 200, body: { results: [{latitude: 52.5200, longitude: 13.4050, name: "Berlin"}] }.to_json, headers: {})

      # Stub for the weather API call
      stub_request(:get, "https://api.open-meteo.com/v1/forecast").
        with(query: {
          "latitude" => "52.52",
          "longitude" => "13.405",
          "daily" => "temperature_2m_max,temperature_2m_min,weathercode",
          "timezone" => "auto"
        }).
        to_return(status: 200, body: {
          daily: {
            time: ["2024-02-24"],
            temperature_2m_max: [10],
            temperature_2m_min: [2],
            weathercode: [100]
          }
        }.to_json, headers: {})
    end

    context "with valid parameters" do
      let(:valid_params) do
        {
          location: {
            name: "Berlin",
            forecast: {daily: {time: ["2024-02-24"], temperature_2m_max: [10], temperature_2m_min: [2], weathercode: [100]}}.to_json
          }
        }
      end

      it "creates a new location and saves the forecast data" do
        expect {
          post locations_path, params: valid_params
        }.to change(Location, :count).by(1)
        
        expect(response).to have_http_status(:redirect)
        follow_redirect!
        expect(response.body).to include("Berlin")
        new_location = Location.last
        expect(new_location.forecast).to be_present
        expect(new_location.forecast['daily']['time']).to include("2024-02-24")
      end
    end
  end
end
