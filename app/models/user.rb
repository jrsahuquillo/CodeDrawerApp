require 'rake'

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
        :recoverable, :rememberable, :trackable, :validatable, :omniauthable,
        authentication_keys: [:login]

  validates :username, presence: :true, uniqueness: { case_sensitive: false }
  validates_format_of :username, with: /^[a-zA-Z0-9_\.]*$/, :multiline => true
  validate :validate_username
  after_create :populate_data

  has_many :drawers
  has_many :codetools
  has_many :friendships
  has_many :friends, through: :friendships, class_name: "User"
  has_many :notifications, foreign_key: :recipient_id

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
    if User.default_scoped.where(email: username).exists?
      errors.add(:username, :invalid)
    end
  end

  def self.from_omniauth(auth)
    if where(email: auth.info.email).exists?
      user = where(email: auth.info.email).first
      user.provider = auth.provider
      user.uid = auth.uid
      user
    else
      where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
        user.provider = auth.provider
        user.uid = auth.uid
        user.email = auth.info.email
        user.username = auth.info.nickname
        user.password = Devise.friendly_token[0,20]
      end
    end
  end

  def self.search(search_friends)
    self.where("username ILIKE ? OR email ILIKE ?", "%#{search_friends}%", "%#{search_friends}%").uniq
  end

  def collaborated_drawers
    Drawer.includes(:drawer_collaborators).map{|drawer| drawer.drawer_collaborators.where(friend_id: id) }.flatten.map(&:drawer)
  end

  def friend?(friend)
    friends.pluck(:friend_id).include?(friend.id)
  end

  def followed_back_by?(friend)
    friend.friends.pluck(:friend_id).include?(id)
  end

  def total_favorite_codetools
    friend_favorite_codetools = self.codetools.map(&:id)
    favorite_codetools = FavoriteCodetool.all.map(&:codetool_id)
    (friend_favorite_codetools & favorite_codetools).count
  end

  def populate_data
    load Rails.root.join('lib', 'tasks', 'populate_data.rake').to_s
    Rake::Task['db:populate_data'].execute(self)
    Rake.application.clear
  end
end
