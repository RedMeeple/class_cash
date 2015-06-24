class CreateAwards < ActiveRecord::Migration
  def change
    create_table :awards do |t|
      t.integer :student_id
      t.integer :award_type_id
      t.string :reason
      t.integer :payment

      t.timestamps null: false
    end
  end
end
