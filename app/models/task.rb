class Task < ApplicationRecord
  belongs_to :user
  belongs_to :project
  has_many :comments, as: :commentable, dependent: :delete_all

  validates :title, presence: true
  validates :project, presence: true
  validates :completed, inclusion: [true, false]
  validates_date :due_date, on_or_after: lambda { Date.now } 

  def self.by_due_date(user)
    where(completed: false, user: user).order(due_date: :asc).limit(10)
  end

  def self.completed(user)
    where(completed: true, user: user).order(due_date: :asc)
  end

end
