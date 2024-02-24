class Location < ApplicationRecord
  # Associations
  belongs_to :user

  # Validations
  validates :name, presence: true
end
