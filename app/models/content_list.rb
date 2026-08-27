class ContentList < ApplicationRecord
  belongs_to :list
  belongs_to :content, polymorphic: true
end
