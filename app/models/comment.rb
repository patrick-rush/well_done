class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :commentable, polymorphic: true

  validates :user_id, :content, presence: true
  validates :commentable, presence: true

end
