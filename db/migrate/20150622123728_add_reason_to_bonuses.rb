class AddReasonToBonuses < ActiveRecord::Migration
  def change
    add_column :bonuses, :reason, :string
  end
end
