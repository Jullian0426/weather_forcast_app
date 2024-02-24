require 'rails_helper'

RSpec.describe Location, type: :model do
  let(:user) { User.create(email: 'user@example.com', password: 'password') }

  it 'is valid with valid attributes' do
    location = user.locations.build(name: 'Home')
    expect(location).to be_valid
  end

  it 'is not valid without a name' do
    location = user.locations.build(name: nil)
    expect(location).not_to be_valid
  end
end
