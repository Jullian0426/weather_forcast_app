require 'rails_helper'

RSpec.describe Location, type: :model do
  let(:user) { User.create(email: 'user@example.com', password: 'password') }

  it "is valid with a name and forecast data" do
    user = User.create(email: "test@example.com", password: "password")
    location = user.locations.build(name: "Berlin", forecast: { "temperature" => 20 })
    expect(location).to be_valid
  end
end
