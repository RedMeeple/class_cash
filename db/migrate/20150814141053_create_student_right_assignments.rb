class CreateStudentRightAssignments < ActiveRecord::Migration
  def change
    create_table :student_right_assignments do |t|
      t.integer :student_id
      t.integer :right_id
      t.integer :cash_level

      t.timestamps null: false
    end
  end
end
