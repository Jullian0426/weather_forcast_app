class Location < ApplicationRecord
  # Associations
  belongs_to :user

  # Validations
  validates :name, presence: true
  validates :latitude, presence: true
  validates :longitude, presence: true
end
