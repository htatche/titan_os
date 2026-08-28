# frozen_string_literal: true

class ListsController < ApplicationController
  include Pagination

  def show
    if params.key?(:content_type) && !valid_content_type?
      return render json: { error: "Valid content_types: #{permitted_content_types.join(", ")}" }, status: :bad_request
    end

    list = List.find(params[:id])
    content_lists = content_lists(list)
    content_lists = paginate(content_lists) if params.key?(:page)

    render json: {
      list:
        {
          name: list.name,
          contents: content_lists
        }
    }
  end

  private

  def content_lists(list)
    result = list.content_lists.includes(:content).order(:position)
    result = result.where(content_type: params[:content_type].capitalize) if params.key?(:content_type)

    result
  end

  def permitted_content_types
    %w[tv_show movie season episode]
  end

  def valid_content_type?
    params[:content_type].in?(permitted_content_types)
  end
end
