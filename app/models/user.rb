class User < ApplicationRecord
  # has_secure_password(validations: false)
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable, :recoverable, :rememberable, and :omniauthable

  has_many :tasks
  has_many :projects, through: :tasks
  has_many :projects, foreign_key: :creator_id
  has_many :friendships, dependent: :destroy
  has_many :friends, through: :friendships

  devise :database_authenticatable, :registerable,
  :validatable, :omniauthable, omniauth_providers: [:google_oauth2] 


  # validates :first_name, :last_name, :email, presence: true
  validates :full_name, presence: true
  validates :email, presence: true, uniqueness: true

  def self.search(search)
    where("(first_name like ?) or (last_name like ?) or (email like ?)", "%#{search}%", "%#{search}%", "%#{search}%")
    # if find_by(first_name: search) || find_by(last_name: search) || find_by(email: search)
    # else
    #   all
    # end
  end

  # def full_name
  #   "#{first_name} #{last_name}"
  # end

  def first_name
    full_name.split(/ /).first
  end

  def last_name
    full_name.split(/ /).last
  end

  def self.from_google(email:, full_name:, uid:, avatar_url:)
    user = User.find_or_create_by(email: email) do |u|
      u.uid = uid 
      u.full_name = full_name
      u.avatar_url = avatar_url
      u.password = SecureRandom.urlsafe_base64
      # u.first_name = full_name.split(/ /).first
      # u.last_name = full_name.split(/ /).last
    end
    # user.update(uid: uid, full_name: full_name, avatar_url: avatar_url)
    # return nil unless email =~ /@gmail.com\z/
    # create_with(uid: uid, full_name: full_name, avatar_url: avatar_url, password: password, first_name: first_name, last_name: last_name).find_or_create_by!(email: email)
  end

  # def self.from_omniauth(auth)
  #   where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
  #     user.email = auth.info.email
  #     # user.name = auth.info.name
  #     user.first_name = auth.info.name.split(/ /).first
  #     user.last_name = auth.info.name.split(/ /).last
  #     user.password = Devise.friendly_token[0, 20]
  #     # user.name = auth.info.name   # assuming the user model has a name
  #     # user.image = auth.info.image # assuming the user model has an image
  #     # If you are using confirmable and the provider(s) you use validate emails, 
  #     # uncomment the line below to skip the confirmation emails.
  #     # user.skip_confirmation!
  #   end

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
  # end
end
