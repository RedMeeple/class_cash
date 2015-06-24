class AddReasonToTransactions < ActiveRecord::Migration
  def change
    add_column :transactions, :reason, :string
  end
end
