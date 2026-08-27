class List < ApplicationRecord
  has_many :content_lists

  has_many :tv_shows, through: :content_lists, source: :content, source_type: 'TvShow'
  has_many :movies, through: :content_lists, source: :content, source_type: 'Movie'
  has_many :seasons, through: :content_lists, source: :content, source_type: 'Season'
  has_many :episodes, through: :content_lists, source: :content, source_type: 'Episode'

  def content
    content_lists.includes(:content).map(&:content)
  end
end
