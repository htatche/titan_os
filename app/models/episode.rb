class Episode < ApplicationRecord
  include MediaValidation

  belongs_to :season
  has_many :lists, through: :content_lists

  validates :position, numericality: { only_integer: true }

  def canonical_number = "#{self.class.name} #{self.position}"
end
