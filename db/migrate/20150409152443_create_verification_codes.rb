class CreateVerificationCodes < ActiveRecord::Migration
  def change
    create_table :verification_codes do |t|
      t.string :code
      t.references :user, index: true, foreign_key: true
      t.boolean :verified, default: false

      t.timestamps null: false
    end
  end
end
