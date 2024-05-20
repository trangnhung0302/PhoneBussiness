class CreateItems < ActiveRecord::Migration[7.1]
  def change
    create_table :items do |t|
      t.references :category, null: false, foreign_key: true
      t.references :supplier, null: false, foreign_key: true
      t.string :name, null: false
      t.string :product_no, null: false
      t.integer :quantity, null: false
      t.bigint :purchase_price, null: false
      t.bigint :original_price, null: false
      t.bigint :price, null: false
      t.text :note
      t.integer :order
      t.integer :status
      t.integer :view, default: 0, null: false

      t.timestamps
    end
  end
end
