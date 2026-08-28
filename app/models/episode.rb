# frozen_string_literal: true

class Episode < ApplicationRecord
  include MediaValidation

  belongs_to :season
  has_many :content_lists, as: :content
  has_many :lists, through: :content_lists

  validates :position, numericality: { only_integer: true }
end
