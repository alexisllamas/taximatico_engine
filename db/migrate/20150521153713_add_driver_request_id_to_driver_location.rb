class AddDriverRequestIdToDriverLocation < ActiveRecord::Migration
  def change
    add_reference :driver_locations, :driver_request, index: true, foreign_key: true
  end
end
