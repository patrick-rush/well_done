class Task < ApplicationRecord
  belongs_to :user
  belongs_to :project

  validates :title, :user_id, :project_id, presence: true
  validates :completed, inclusion: [true, false]
  validates_date :due_date, on_or_after: lambda { Date.now } 
end
