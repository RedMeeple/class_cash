class CreateLoans < ActiveRecord::Migration
  def change
    create_table :loans do |t|
      t.integer :student_id
      t.integer :recipient_id
      t.integer :amount
      t.integer :balance
      t.integer :interest
      t.date :end_date
      t.integer :weeks
      t.boolean :accepted

      t.timestamps null: false
    end
  end
end
