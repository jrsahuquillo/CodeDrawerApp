class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
        :recoverable, :rememberable, :validatable, authentication_keys: [:login]

  validates :username, presence: :true, uniqueness: { case_sensitive: false }
  validates_format_of :username, with: /^[a-zA-Z0-9_\.]*$/, :multiline => true
  validate :validate_username
  has_many :drawers
  has_many :codetools
  has_many :friendships
  has_many :friends, through: :friendships, class_name: "User"
  attr_accessor :login

  def login
    @login || self.username || self.email
  end

  def self.find_for_database_authentication warden_conditions
    conditions = warden_conditions.dup
    login = conditions.delete(:login)
    where(conditions).where(["lower(username) = :value OR lower(email) = :value", {value: login.strip.downcase}]).first
  end

  def validate_username
    if User.where(email: username).exists?
      errors.add(:username, :invalid)
    end
  end

  def self.search(search_friends)
    self.where("username ILIKE ? OR email ILIKE ?", "%#{search_friends}%", "%#{search_friends}%").uniq
  end

  def current_user_friend?(current_user)
    current_user.friendships.map(&:friend_id).include?(id)
  end

end
