class Movie < ApplicationRecord
  has_many :lists, through: :content_lists
end
