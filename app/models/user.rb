class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable, :recoverable, :rememberable, and :omniauthable
  devise :database_authenticatable, :registerable,
         :validatable, :omniauthable, omniauth_providers: [:facebook] 

  has_many :tasks
  has_many :projects, through: :tasks
  has_many :projects, foreign_key: :creator_id

  validates :first_name, :last_name, :email, presence: true
  validates :email, presence: true, uniqueness: true

  def full_name
    "#{first_name} #{last_name}"
  end

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      # user.name = auth.info.name
      user.first_name = auth.info.name.split(/ /).first
      user.last_name = auth.info.name.split(/ /).last
      user.password = Devise.friendly_token[0, 20]
      # user.name = auth.info.name   # assuming the user model has a name
      # user.image = auth.info.image # assuming the user model has an image
      # If you are using confirmable and the provider(s) you use validate emails, 
      # uncomment the line below to skip the confirmation emails.
      # user.skip_confirmation!
    end

    # def apply_omniauth(auth)
    #   update_attributes(
    #     provider: auth.provider,
    #     uid: auth.uid
    #   )
    # end

    # def has_facebook_linked?
    #   self.provider.present? && self.uid.present?
    # end

    # devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable, :omniauthable, omniauth_providers: [:facebook]

    # def self.from_omniauth(auth)
    #   where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
    #     user.email = auth.info.email
    #     user.provider = auth.provider
    #     user.uid = auth.uid
    #     user.password = Devise.friendly_token[0,20]
    #   end
    # end
  end
end
