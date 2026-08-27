class TvShow < ApplicationRecord
  include MediaValidation

  has_many :seasons, dependent: :destroy
  has_many :episodes, through: :seasons, dependent: :destroy

  has_many :content_lists, as: :content
  has_many :lists, through: :content_lists
end
