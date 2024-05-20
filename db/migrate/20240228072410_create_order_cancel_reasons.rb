class CreateOrderCancelReasons < ActiveRecord::Migration[7.1]
  def change
    create_table :order_cancel_reasons do |t|
      t.string :name, null: false

      t.timestamps
    end
  end
end
