class RenameStatusToCompleted < ActiveRecord::Migration[6.0]
  def up
    rename_column :tasks, :status, :completed
  end

  def down
    rename_column :tasks, :completed, :status
  end
end
