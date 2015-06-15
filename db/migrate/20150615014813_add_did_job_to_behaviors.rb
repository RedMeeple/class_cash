class AddDidJobToBehaviors < ActiveRecord::Migration
  def change
    add_column :behaviors, :did_job, :boolean
  end
end
