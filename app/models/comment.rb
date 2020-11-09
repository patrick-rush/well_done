class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :commentable, polymorphic: true

  validates :user_id, :content, presence: true
  # validates :task_id, allow_nil: true
  # validates :project_id, allow_nil: true
  # validates :task_id, presence: true, unless: :project_id
  # validates :project_id, presence: true, unless: :task_id
  validates :commentable, presence: true

end
