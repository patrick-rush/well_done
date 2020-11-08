class CreateFriendshipsTable < ActiveRecord::Migration[6.0]
  def change
    create_table :friendships do |t|
      t.references :user, foreign_key: true
      t.references :friend
    end
  end
end
