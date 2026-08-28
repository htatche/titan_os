# frozen_string_literal: true

class ListsController < ApplicationController
  def show
    if params.key?(:content_type) && !valid_content_type?
      return render json: { error: "Valid content_types: #{permitted_content_types.join(", ")}" }, status: :bad_request
    end

    list = List.find(params[:id])
    data = data(list)

    json = {
      json: {
        list:
          {
            name: list.name,
            data: data
          }
      }
    }

    json[:json][:pagination] = {
      page: params[:page],
      per_page: params[:per_page],
      total: data.size
    } if params.key?(:page)

    render json
  end

  private

  def data(list)
    data = filter_content(list)
    data = paginate_content(data) if params.key?(:page)

    data.map do |content_list|
      attrs = content_list.content.as_json.with_indifferent_access.merge(type: content_list.content.class.name.underscore)
      attrs = attrs.merge(number: content_list.content.canonical_number) if content_list.content.respond_to?(:canonical_number)

      attrs.slice(:number, :title, :original_title, :year, :type)
    end
  end

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
