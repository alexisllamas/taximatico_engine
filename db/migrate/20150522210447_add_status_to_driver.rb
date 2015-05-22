class AddStatusToDriver < ActiveRecord::Migration
  def change
    add_column :drivers, :status, :integer, default: 0
  end
end
