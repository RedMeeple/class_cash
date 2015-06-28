class AddLoanAbilityToStudents < ActiveRecord::Migration
  def change
    add_column :students, :can_loan, :boolean
  end
end
