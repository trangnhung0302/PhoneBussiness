class CreateCarts < ActiveRecord::Migration[7.1]
  def change
    create_table :carts do |t|
      t.references :customer, null: false, foreign_key: true
      t.references :item, null: false, foreign_key: true
      t.references :item_color, null: true, foreign_key: true
      t.integer :quantity, null: false

      t.timestamps
    end
  end
end
