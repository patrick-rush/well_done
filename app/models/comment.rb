class Comment < ApplicationRecord
  belongs_to :task
  belongs_to :user
  belongs_to :project

  validates :user_id, :content, presence: true
  validates :project_id, presence: true, unless: :task_id
  validates :task_id, presence: true, unless: :project_id

end
