# frozen_string_literal: true

class ContentList < ApplicationRecord
  belongs_to :list
  belongs_to :content, polymorphic: true

  validates :position, numericality: { only_integer: true }
end
