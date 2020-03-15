class Codetool < ApplicationRecord
  belongs_to :drawer
  belongs_to :user

  validates :title, presence: true

  scope :is_public, ->{ where(public: true) }

  def self.search(search)
    self.where("title ILIKE ? OR content ILIKE ?", "%#{search}%", "%#{search}%").uniq
  end

  def belongs_to_current_user?(current_user)
     current_user.codetools.include?(self)
  end

end
