class CreateStoreItems < ActiveRecord::Migration
  def change
    create_table :store_items do |t|
      t.string :name
      t.integer :price
      t.integer :stock
      t.integer :instructor_id

      t.timestamps null: false
    end
  end
end
