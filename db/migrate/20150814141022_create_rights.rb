class CreateRights < ActiveRecord::Migration
  def change
    create_table :rights do |t|
      t.string :description
      t.integer :instructor_id

      t.timestamps null: false
    end
  end
end
