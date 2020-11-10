class RemoveCreatorIdFromProjects < ActiveRecord::Migration[6.0]
  def change
    remove_column :projects, :creator_id
  end
end
