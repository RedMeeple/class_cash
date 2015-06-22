class CreateExtras < ActiveRecord::Migration
  def change
    create_table :extras do |t|
      t.integer :instructor_id
      t.integer :student_id
      t.integer :amount
      t.string :reason

      t.timestamps null: false
    end
  end
end
