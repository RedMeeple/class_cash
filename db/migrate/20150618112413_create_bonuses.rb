class CreateBonuses < ActiveRecord::Migration
  def change
    create_table :bonuses do |t|
      t.integer :period_id
      t.integer :amount

      t.timestamps null: false
    end
  end
end
