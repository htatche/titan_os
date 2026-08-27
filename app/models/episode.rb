class Episode < ApplicationRecord
  belongs_to :season
  belongs_to :tv_show, :through => :season
  has_many :lists, through: :content_lists
end
