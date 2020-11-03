class Project < ApplicationRecord
    has_many :tasks
    has_many :users, through: :tasks
    
    validates :title, presence: true
    validates :private, inclusion: [true, false]
    validates :status, inclusion: { in: %w(open closed) }
end
