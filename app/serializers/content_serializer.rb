# frozen_string_literal: true

class ContentSerializer
  attr_accessor :content

  def initialize(content)
    @content = content
  end

  def as_json
    json = {
      title: content.title,
      original_title: content.original_title,
      year: content.year,
      type: content.class.name.underscore
    }

    json = json.merge(number: "#{content.class.name} #{content.position}") if canonical_number?

    json
  end

  private

  def canonical_number?
    content.respond_to?(:position)
  end
end
