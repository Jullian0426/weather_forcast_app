require 'rails_helper'

RSpec.describe "Location management", type: :system, js: true do
  let!(:user) { FactoryBot.create(:user) }

  before do
    driven_by(:selenium_chrome_headless)
    sign_in user
  end

  it "allows a user to create and then delete a location" do
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

    visit root_path

    fill_in "Enter Location:", with: "Berlin"
    # If you have other fields to fill, do so here

    click_on "Save and Get Forecast"

    expect(page).to have_content("Berlin")
    expect(page).to have_css("#chart-#{Location.last.id}")


    click_on "Delete", match: :first

    expect(page).not_to have_content("Berlin")
  end
end
