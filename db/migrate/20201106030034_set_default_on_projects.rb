class SetDefaultOnProjects < ActiveRecord::Migration[6.0]
  def change
    change_column_default :projects, :status, "open"
  end
end
