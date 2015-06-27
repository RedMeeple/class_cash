class AddDateToJobs < ActiveRecord::Migration
  def change
    add_column :jobs, :last_date_done, :date
  end
end
