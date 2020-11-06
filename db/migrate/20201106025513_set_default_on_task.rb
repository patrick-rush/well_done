class SetDefaultOnTask < ActiveRecord::Migration[6.0]
  def change
    change_column_default :tasks, :status, "incomplete"
  end
end
