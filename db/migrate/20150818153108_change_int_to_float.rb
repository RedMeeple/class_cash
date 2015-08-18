class ChangeIntToFloat < ActiveRecord::Migration
  def change
    change_column :loans, :amount, :float
      change_column :loans, :balance, :float
  end
end
