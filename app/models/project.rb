class Project < ApplicationRecord
    has_many :tasks, inverse_of: :project 
    accepts_nested_attributes_for :tasks
    has_many :users, through: :tasks
    has_many :comments, as: :commentable
    
    validates :title, presence: true
    validates :private, inclusion: [true, false]
    validates :status, inclusion: { in: %w(open closed) }

    def incomplete_tasks
        tasks.where(completed: false)
    end

    def completed_tasks
        tasks.where(completed: true)
    end
end
