class User < ApplicationRecord
  has_many :tasks
  has_many :projects, through: :tasks
  has_many :friendships, dependent: :destroy
  has_many :friends, through: :friendships
  has_many :comments

  devise :database_authenticatable, :registerable, :recoverable,
  :validatable, :omniauthable, omniauth_providers: [:google_oauth2] 

  validates :full_name, presence: true
  validates :email, presence: true, uniqueness: true

  def self.search(search)
    where("(full_name like ?) or (email like ?)", "%#{search}%", "%#{search}%")
  end

  def self.from_google(email:, full_name:, uid:, avatar_url:)
    user = User.find_or_create_by(email: email) do |u|
      u.uid = uid 
      u.full_name = full_name
      u.avatar_url = avatar_url
      u.password = SecureRandom.urlsafe_base64
    end
  end

  def public_projects
    projects.where(private: false)
  end 

  def is_friends_with?(user)
    friends.include?(user)
  end

end
