# frozen_string_literal: true

class ListsController < ApplicationController
  def show
    if params.key?(:content_type) && !valid_content_type?
      return render json: { error: "Valid content_types: #{permitted_content_types.join(", ")}" }, status: :bad_request
    end

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
    list.content(params[:content_type]).map do |content|
      attrs = content.as_json.with_indifferent_access.merge(type: content.class.name.underscore)

      attrs = attrs.merge(number: content.canonical_number) if content.respond_to?(:canonical_number)

      attrs.slice(:number, :title, :original_title, :year, :type)
    end
  end

  def permitted_content_types
    %w[tv_show movie season episode]
  end

  def valid_content_type?
    params[:content_type].in?(permitted_content_types)
  end
end
