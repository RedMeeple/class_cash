class CreatePurchases < ActiveRecord::Migration
  def change
    create_table :purchases do |t|
      t.integer :student_id
      t.integer :store_item_id

      t.timestamps null: false
    end
  end
end
