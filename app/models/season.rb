class Season < ApplicationRecord
  belongs_to :tv_show
  has_many :lists, through: :content_lists
end
