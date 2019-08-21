class Codetool < ApplicationRecord
  belongs_to :drawer
  belongs_to :user

  validates :title, presence: true
  validates :content, presence: true
end
