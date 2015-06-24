class CreateAwardTypes < ActiveRecord::Migration
  def change
    create_table :award_types do |t|
      t.string :name
      t.string :picture

      t.timestamps null: false
    end
  end
end
