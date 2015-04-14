class RemoveIndexAndValidationsForUser < ActiveRecord::Migration
  def up
    remove_index :users, :email

    add_index :users, :phone_number, unique: true
  end

  def down
    add_index :users, :email, unique: true

    remove_index :users, :phone_number
  end
end
