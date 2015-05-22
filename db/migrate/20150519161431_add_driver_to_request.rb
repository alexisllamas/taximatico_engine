class AddDriverToRequest < ActiveRecord::Migration
  def change
    change_table :requests do |t|
      t.references :driver, index: true
    end
  end
end
