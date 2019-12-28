class Friendship < ApplicationRecord
  belongs_to :user
  belongs_to :friend, class_name: "User"
  has_many :codetools
  validates_uniqueness_of :friend_id
end
