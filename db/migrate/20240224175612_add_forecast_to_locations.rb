class AddForecastToLocations < ActiveRecord::Migration[7.1]
  def change
    add_column :locations, :forecast, :jsonb
  end
end
