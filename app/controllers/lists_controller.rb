# frozen_string_literal: true

class ListsController < ApplicationController
  def show
    if params.key?(:content_type) && !valid_content_type?
      return render json: { error: "Valid content_types: #{permitted_content_types.join(", ")}" }, status: :bad_request
    end

    list = List.find(params[:id])
    content_lists = filter_content(list)
    content_lists = paginate_content(content_lists) if params.key?(:page)

    json = {
      json: {
        list:
          {
            name: list.name,
            contents: content_lists.map { |content_list| ContentSerializer.new(content_list.content) }
          }
      }
    }

    json[:json][:pagination] = {
      page: params[:page],
      per_page: params[:per_page],
      # total: data.size
    } if params.key?(:page)

    render json
  end

  private

  def filter_content(list)
    result = list.content_lists.includes(:content).order(:position)
    result = result.where(content_type: params[:content_type].capitalize) if params.key?(:content_type)

    result
  end

  def paginate_content(result)
    page = params[:page].to_i
    page = 1 if page < 1

    per_page = 3

    result.offset((page - 1) * per_page)
          .limit(per_page)
  end

  def permitted_content_types
    %w[tv_show movie season episode]
  end

  def valid_content_type?
    params[:content_type].in?(permitted_content_types)
  end
end
