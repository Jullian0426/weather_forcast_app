require 'rails_helper'

RSpec.describe Location, type: :model do
  let(:user) { User.create(email: 'user@example.com', password: 'password') }

  it 'is valid with valid attributes' do
    location = user.locations.build(name: 'Home', latitude: '40.7128', longitude: '-74.0060')
    expect(location).to be_valid
  end

  it 'is not valid without a name' do
    location = user.locations.build(name: nil, latitude: '40.7128', longitude: '-74.0060')
    expect(location).not_to be_valid
  end

  it 'is not valid without a latitude' do
    location = user.locations.build(name: 'Home', latitude: nil, longitude: '-74.0060')
    expect(location).not_to be_valid
  end

  it 'is not valid without a longitude' do
    location = user.locations.build(name: 'Home', latitude: '40.7128', longitude: nil)
    expect(location).not_to be_valid
  end
end
