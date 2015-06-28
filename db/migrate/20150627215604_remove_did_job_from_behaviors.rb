class RemoveDidJobFromBehaviors < ActiveRecord::Migration
  def change
    remove_column :behaviors, :did_job, :boolean
  end
end
