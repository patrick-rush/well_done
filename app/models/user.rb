class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable, :recoverable, :rememberable, and :omniauthable
  devise :database_authenticatable, :registerable,
         :validatable #, :omniauthable, omniauth_providers: [:google_oauth2]

  has_many :tasks
  has_many :projects, through: :tasks

  validates :first_name, :last_name, presence: true

  def full_name
    "#{first_name} #{last_name}"
  end
end
