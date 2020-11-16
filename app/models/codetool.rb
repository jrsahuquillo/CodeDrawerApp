class Codetool < ApplicationRecord
  belongs_to :drawer
  belongs_to :user

  validates :title, presence: true
  after_validation :set_slug, only: [:create, :update]

  default_scope { order(position: :asc, updated_at: :desc) }

  scope :is_public, ->{ where(public: true) }


  def self.search(search)
    searching_words = search.split(',')
    result = []
    searching_words.each do |word|
      result << self.where("title ILIKE ? OR content ILIKE ?", "%#{word}%", "%#{word}%").uniq
    end
    result.flatten.uniq
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
