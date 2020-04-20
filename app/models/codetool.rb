class Codetool < ApplicationRecord
  belongs_to :drawer
  belongs_to :user

  validates :title, presence: true
  after_validation :set_slug, only: [:create, :update]

  scope :is_public, ->{ where(public: true) }


  def self.search(search)
    self.where("title ILIKE ? OR content ILIKE ?", "%#{search}%", "%#{search}%").uniq
  end

  def belongs_to_user?(user)
     user.present? && user.codetools.include?(self)
  end

  def favorited?(current_user_id)
    FavoriteCodetool.where(user_id: current_user_id, codetool_id: self.id).present?
  end

  def total_favorites
    FavoriteCodetool.where(codetool_id: self.id).count
  end

  def pinned?(current_user_id)
    PinCodetool.where(user_id: current_user_id, codetool_id: self.id).present?
  end

  def to_param
    "#{id}-#{slug}"
  end

  private

  def set_slug
    self.slug = title.to_s.parameterize
  end
end
