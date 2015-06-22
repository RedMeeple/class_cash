class CreateDailyBalances < ActiveRecord::Migration
  def change
    create_table :daily_balances do |t|
      t.integer :student_id
      t.date :date
      t.integer :amount

      t.timestamps null: false
    end
  end
end
