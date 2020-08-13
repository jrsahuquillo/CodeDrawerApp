class Drawer < ApplicationRecord
  validates :title, presence: true
  after_validation :set_slug, only: [:create, :update]

  default_scope { order(position: :asc, created_at: :desc)}

  belongs_to :user
  has_many :codetools, dependent: :destroy

  has_many :drawer_collaborators
  has_many :friends, through: :drawer_collaborators, dependent: :destroy

  after_initialize :set_defaults, unless: :persisted?

  def set_defaults
    self.position ||= 0
  end

  def to_param
    "#{id}-#{slug}"
  end

  private

  def set_slug
    self.slug = title.to_s.parameterize
  end

end
