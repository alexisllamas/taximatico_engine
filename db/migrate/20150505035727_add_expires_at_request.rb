class AddExpiresAtRequest < ActiveRecord::Migration
  def change
    add_column :requests, :expires_at, :datetime, index: true
  end
end
