class RemoveLatLongFromLocations < ActiveRecord::Migration[7.1]
  def change
    remove_column :locations, :latitude, :decimal
    remove_column :locations, :longitude, :decimal
  end
end
