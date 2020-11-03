class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable, :recoverable, :rememberable, and :omniauthable
  devise :database_authenticatable, :registerable,
         :validatable

  has_many :tasks
  has_many :projects, through: :tasks

  validates :first_name, :last_name, presence: true
end
