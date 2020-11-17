class Codetool < ApplicationRecord
  belongs_to :drawer
  belongs_to :user

  validates :title, presence: true
  after_validation :set_slug, only: [:create, :update]

  default_scope { order(position: :asc, updated_at: :desc) }

  scope :is_public, ->{ where(public: true) }

  def self.search(search)
    split_character = search.include?('&') ? '&' : ','
    searching_words =  search.split(split_character).collect(&:strip)
    result = []
    searching_words.each do |word|
      codetool_matching_search = self.where("title ILIKE ? OR content ILIKE ?", "%#{word}%", "%#{word}%").uniq
      if split_character == '&'
        codetool_matching_search.each do |codetool|
          if (codetool.title.downcase.split(" ") & searching_words).sort == searching_words.sort ||
            (codetool.content.downcase.split(" ") & searching_words).sort == searching_words.sort
            result << codetool
          end
        end
      else
        result << codetool_matching_search
      end
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
