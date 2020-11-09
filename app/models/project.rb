class Project < ApplicationRecord
    has_many :tasks
    has_many :users, through: :tasks
    belongs_to :creator, class_name: :User, foreign_key: :creator_id
    
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
