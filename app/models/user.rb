require 'rake'

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
        :recoverable, :rememberable, :validatable, authentication_keys: [:login]

  validates :username, presence: :true, uniqueness: { case_sensitive: false }
  validates_format_of :username, with: /^[a-zA-Z0-9_\.]*$/, :multiline => true
  validate :validate_username
  after_validation :populate_data, only: :create

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
    if User.where(email: username).exists?
      errors.add(:username, :invalid)
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
    # binding.pry
    # load File.join(RAILS_ROOT, 'lib', 'tasks', 'populate_data.rake')
    # Rake::Task[populate_data].invoke
  end
end
