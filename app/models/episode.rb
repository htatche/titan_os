class Episode < ApplicationRecord
  belongs_to :season
  has_many :lists, through: :content_lists
end
