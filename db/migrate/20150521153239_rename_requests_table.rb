class RenameRequestsTable < ActiveRecord::Migration
  def change
    rename_table :requests, :driver_requests
  end
end
