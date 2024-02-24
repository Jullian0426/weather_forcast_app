class ChangeNameNotNullInLocations < ActiveRecord::Migration[7.1]
  def change
    change_column_null :locations, :name, false
  end
end
