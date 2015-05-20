class AddStatusToRequest < ActiveRecord::Migration
  def change
    add_column :requests, :status, :integer, default: 0, index: true
  end
end
