class ChangeStatusToBooleanInTasks < ActiveRecord::Migration[6.0]
  def up
    change_column :tasks, :status, :boolean
  end

  def down
    change_column :tasks, :status, :string
  end
end
