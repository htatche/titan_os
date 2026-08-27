class Movie < ApplicationRecord
  has_many :content_lists, as: :content
  has_many :lists, through: :content_lists
end
