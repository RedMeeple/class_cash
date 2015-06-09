class CreatePeriods < ActiveRecord::Migration
  def change
    create_table :periods do |t|
      t.integer :instructor_id
      t.integer :payscale
      t.string :name

      t.timestamps null: false
    end
  end
end
