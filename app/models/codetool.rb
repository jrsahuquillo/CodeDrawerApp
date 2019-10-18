class Codetool < ApplicationRecord
  belongs_to :drawer
  belongs_to :user

  validates :title, presence: true
  validates :content, presence: true

  def self.search(search)
    searched_codetools = []
    searched_codetools << self.where("title ILIKE ?", "%#{search}%")
    searched_codetools << self.where("content ILIKE ?", "%#{search}%")
    searched_codetools.flatten
  end

end
