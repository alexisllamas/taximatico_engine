class CreateDriverLocations < ActiveRecord::Migration
  def change
    create_table :driver_locations do |t|
      t.float :latitude
      t.float :longitude
      t.references :driver, index: true

      t.timestamps null: false
    end
  end
end
