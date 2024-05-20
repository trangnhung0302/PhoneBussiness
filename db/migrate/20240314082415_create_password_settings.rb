class CreatePasswordSettings < ActiveRecord::Migration[7.1]
  def change
    create_table :password_settings do |t|
      t.references :customer, null: false, foreign_key: true
      t.string :token, null: false
      t.datetime :expired_at, null: false

      t.timestamps
    end
  end
end
