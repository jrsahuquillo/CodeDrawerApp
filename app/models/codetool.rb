class Codetool < ApplicationRecord
  belongs_to :drawer
  belongs_to :user

  validates :title, presence: true

  scope :is_public, ->{ where(public: true) }

  after_validation :set_slug, only: [:create, :update]

  def self.search(search)
    self.where("title ILIKE ? OR content ILIKE ?", "%#{search}%", "%#{search}%").uniq
  end

  def belongs_to_current_user?(current_user)
     current_user.codetools.include?(self)
  end

  def favorited?(current_user_id)
    FavoriteCodetool.where(user_id: current_user_id, codetool_id: self.id).present?
  end

  def total_favorites
    FavoriteCodetool.where(codetool_id: self.id).count
  end

  def to_param
    "#{id}-#{slug}"
  end

  private

  def set_slug
    self.slug = title.to_s.parameterize
  end
end
