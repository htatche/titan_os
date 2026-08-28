# frozen_string_literal: true

class Season < ApplicationRecord
  include MediaValidation

  belongs_to :tv_show
  has_many :episodes, dependent: :destroy
  has_many :content_lists, as: :content
  has_many :lists, through: :content_lists

  validates :position, numericality: { only_integer: true }
end
