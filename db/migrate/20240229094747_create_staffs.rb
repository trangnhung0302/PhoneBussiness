class CreateStaffs < ActiveRecord::Migration[7.1]
  def change
    create_table :staffs do |t|
      t.string :email, null: false
      t.string :name, null: false
      t.string :phone, null: false
      t.string :password_digest, null: false
      t.integer :status, default: 10

      t.timestamps
    end

    add_index :staffs, :email, unique: true
  end
end
