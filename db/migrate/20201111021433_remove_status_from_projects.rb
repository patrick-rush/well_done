class RemoveStatusFromProjects < ActiveRecord::Migration[6.0]
  def change
    remove_column :projects, :status
  end
end
