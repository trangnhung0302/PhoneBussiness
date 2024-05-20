class CreateOrders < ActiveRecord::Migration[7.1]
  def change
    create_table :orders do |t|
      t.references :customer, null: false, foreign_key: true
      t.references :payment_type, null: false, foreign_key: true
      t.references :staff, foreign_key: true
      t.references :order_cancel_reason, foreign_key: true
      t.references :customer_destination, null: false, foreign_key: true
      t.string :order_number, null: false
      t.bigint :total_price, null: false
      t.bigint :ship_amount, null: false
      t.string :message
      t.integer :status, null: false, default: 10
      t.integer :payment_status, null: false, default: 10
      t.integer :transport_service_id, null: false
      t.string :transport_service_name, null: false

      t.timestamps
    end

    add_index :orders, :order_number, unique: true
  end
end
