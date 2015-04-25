class CreateDrivers < ActiveRecord::Migration
  def change
    create_table :drivers do |t|
      t.string :name
      t.integer :taxi_number
      t.float :latitude
      t.float :longitude

      t.timestamps null: false
    end
  end
end
