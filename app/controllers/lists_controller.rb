# frozen_string_literal: true

class ListsController < ApplicationController
  def show
    list = List.find(params[:id])

    render json: {
      list:
        {
          name: list.name,
          content: content(list)
        }
    }
  end

  private

  def content(list)
    list.content.map do |content|
      attrs = content.as_json.with_indifferent_access.merge(type: content.class.name.underscore)

      if content.is_episode? || content.is_season?
        canonical_number = "#{content.class.name} #{content.position}"

        attrs = attrs.merge(number: canonical_number)
      end

      attrs.slice(:number, :title, :original_title, :year, :type)
    end
  end
end
