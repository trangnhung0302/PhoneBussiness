class CreateCustomerDestinations < ActiveRecord::Migration[7.1]
  def change
    create_table :customer_destinations do |t|
      t.references :customer, null: false, foreign_key: true
      t.string :recipient_name
      t.string :recipient_phone
      t.integer :province_id
      t.string :province_name
      t.integer :district_id
      t.string :district_name
      t.string :ward_code
      t.string :ward_name
      t.string :address
      t.boolean :default
      t.boolean :is_deleted, null: false, default: false

      t.timestamps
    end
  end
end
