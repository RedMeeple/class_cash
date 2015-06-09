class CreateJobs < ActiveRecord::Migration
  def change
    create_table :jobs do |t|
      t.integer :student_id
      t.string :description
      t.integer :payscale

      t.timestamps null: false
    end
  end
end
