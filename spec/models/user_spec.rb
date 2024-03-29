require 'rails_helper'

RSpec.describe User, type: :model do
  it 'is valid with valid attributes' do
    user = User.new(email: 'test@example.com', password: 'password')
    expect(user).to be_valid
  end

  it 'is not valid without an email' do
    user = User.new(email: nil, password: 'password')
    expect(user).not_to be_valid
  end

  it "has many locations" do
    association = described_class.reflect_on_association(:locations)
    expect(association.macro).to eq :has_many
  end
end
