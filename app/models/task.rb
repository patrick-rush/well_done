class Task < ApplicationRecord
  belongs_to :user
  belongs_to :project

  validates :title, :user_id, :project_id, presence: true
  validates :status, inclusion: { in: %w(incomplete in-progress completed) }
  validates :due_date, date: { after_or_equal_to: Time.now }
end
