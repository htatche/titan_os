class TvShow < ApplicationRecord
  has_many :seasons
  has_many :episodes, :through => :season

  has_many :content_lists, as: :content
  has_many :lists, through: :content_lists
end
