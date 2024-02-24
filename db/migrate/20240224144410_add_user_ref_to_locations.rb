class AddUserRefToLocations < ActiveRecord::Migration[7.1]
  def change
    add_reference :locations, :user, null: false, foreign_key: true
  end
end
