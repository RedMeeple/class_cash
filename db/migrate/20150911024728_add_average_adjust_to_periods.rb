class AddAverageAdjustToPeriods < ActiveRecord::Migration
  def change
    add_column :periods, :average_adjust, :integer
  end
end
