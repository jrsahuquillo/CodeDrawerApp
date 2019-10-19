class Codetool < ApplicationRecord
  belongs_to :drawer
  belongs_to :user

  validates :title, presence: true
  validates :content, presence: true

  def self.search(search)
    self.where("title ILIKE ? OR content ILIKE ?", "%#{search}%", "%#{search}%").uniq
  end

end
