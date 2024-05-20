class CreatePaymentTypes < ActiveRecord::Migration[7.1]
  def change
    create_table :payment_types do |t|
      t.string :name, null: false
      t.string :bank_name
      t.string :account_holders
      t.string :account_number
      
      t.timestamps
    end
  end
end
