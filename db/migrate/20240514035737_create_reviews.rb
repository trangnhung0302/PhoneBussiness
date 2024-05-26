class CreateReviews < ActiveRecord::Migration[7.1]
  def change
    create_table :reviews do |t|
      t.references :order, null: false, foreign_key: true
      t.integer :ratings, null: false
      t.text :review
      t.text :reply

      t.timestamps
    end
  end
end
