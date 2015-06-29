class CreateStudents < ActiveRecord::Migration
  def change
    create_table :students do |t|
      t.integer :cash
      t.integer :period_id
      t.boolean :richest

      t.timestamps null: false
    end
  end
end
