class CreateStudents < ActiveRecord::Migration
  def change
    create_table :students do |t|
      t.string :first_name
      t.string :last_name
      t.string :email
      t.integer :cash
      t.integer :period_id
      t.string :password_digest
      t.boolean :good_behavior
      t.boolean :richest

      t.timestamps null: false
    end
  end
end
