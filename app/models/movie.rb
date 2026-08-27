class Movie < ApplicationRecord
  include MediaValidation

  has_many :content_lists, as: :content
  has_many :lists, through: :content_lists
end
