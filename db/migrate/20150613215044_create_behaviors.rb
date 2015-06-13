class CreateBehaviors < ActiveRecord::Migration
  def change
    create_table :behaviors do |t|
      t.integer :student_id
      t.date :date
      t.boolean :well_behaved

      t.timestamps null: false
    end
  end
end
