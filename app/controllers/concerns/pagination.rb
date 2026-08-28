# frozen_string_literal: true

module Pagination
  PER_PAGE = 3
  MAX_PER_PAGE = 100

  extend ActiveSupport::Concern

  included do
    before_action :set_pagination_params
  end

  attr_accessor :page, :per_page

  def paginate(collection)
    return { data: collection } unless params[:page].present?

    @page = 1 if @page < 1
    @per_page = PER_PAGE if @per_page < 1
    @per_page = MAX_PER_PAGE if @per_page > MAX_PER_PAGE

    total = collection.count

    {
      data: data(collection),
      pagination: {
        page: page,
        per_page: @per_page,
        pages: (total.to_f / @per_page).ceil,
        total: total
      }
    }
  end

  def data(collection)
    collection.offset((page - 1) * @per_page).limit(@per_page)
  end

  def serialize(content_list)
    ContentSerializer.new(content_list.content).as_json
  end

  def set_pagination_params
    @page = params[:page].to_i
    @per_page = params[:per_page].to_i
  end
end
