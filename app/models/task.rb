class Task < ApplicationRecord
  belongs_to :user
  belongs_to :project
  has_many :comments, as: :commentable

  validates :title, :user_id, presence: true
  validates :project, presence: true
  validates :completed, inclusion: [true, false]
  validates_date :due_date, on_or_after: lambda { Date.now } 

  def self.by_due_date
    where(completed: false).order(due_date: :asc).limit(10)
  end

  def readable_due_date
    due_date.strftime("%b %d, %Y")
  end

end
