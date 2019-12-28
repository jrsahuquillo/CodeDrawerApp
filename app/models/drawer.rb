class Drawer < ApplicationRecord
  validates :title, presence: true

  default_scope { order(created_at: :desc)}

  belongs_to :user
  has_many :codetools, dependent: :destroy

  after_initialize :set_defaults, unless: :persisted?

  def set_defaults
    self.position ||= 0
  end
end
