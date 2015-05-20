class CleanTablesFromDatabase < ActiveRecord::Migration
  def change
    remove_column :drivers, :latitude,  :float
    remove_column :drivers, :longitude, :float

    remove_column :users, :latitude,  :float
    remove_column :users, :longitude, :float
  end
end
