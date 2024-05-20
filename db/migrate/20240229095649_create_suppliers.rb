class CreateSuppliers < ActiveRecord::Migration[7.1]
  def change
    create_table :suppliers do |t|
      t.string :name, null: false
      t.string :logo
      t.integer :order

      t.timestamps
    end
  end
end
