# frozen_string_literal: true

class ListsController < ApplicationController
  include Pagination

  def show
    if params.key?(:content_type) && !valid_content_type?
      return render json: { error: "Valid content_types: #{permitted_content_types.join(", ")}" }, status: :bad_request
    end

    list = List.find(params[:id])
    result = paginate(scope(list.content_lists))

    result[:data] = result[:data].map { |item| serialize(item) }

    render json: { list: { name: list.name, contents: result } }
  end

  private

  def scope(content_lists)
    content_lists = content_lists.includes(:content)
    content_lists = content_lists.where(content_type: params[:content_type].camelize) if params.key?(:content_type)

    content_lists.order(:position)
  end

  def valid_content_type?
    params[:content_type].in?(permitted_content_types)
  end

  def permitted_content_types
    %w[tv_show movie season episode]
  end
end
