class CreateProjects < ActiveRecord::Migration[6.0]
  def change
    create_table :projects do |t|
      t.string :title
      t.boolean :private, default: true
      t.string :status

      t.timestamps
    end
  end
end
