class CreatePurchaseTrackers < ActiveRecord::Migration
  def change
    create_table :purchase_trackers do |t|
      t.integer :student_id
      t.string :item
      t.integer :amount

      t.timestamps null: false
    end
  end
end
