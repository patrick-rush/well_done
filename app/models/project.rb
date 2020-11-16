class Project < ApplicationRecord
    has_many :tasks
    accepts_nested_attributes_for :tasks
    has_many :users, through: :tasks
    has_many :comments, as: :commentable
    
    validates :title, presence: true
    validates :private, inclusion: [true, false]

    def incomplete_tasks
        tasks.where(completed: false).order(due_date: :asc)
    end

    def completed_tasks
        tasks.where(completed: true).order(due_date: :asc)
    end
end
