# frozen_string_literal: true

require "rails_helper"

RSpec.describe Pagination do
  let(:controller) { ListsController.new }

  let!(:movies) do
    5.times.map do |i|
      Movie.create!(
        title: "Movie #{i + 1}",
        original_title: "Movie #{i + 1}",
        year: 2000 + i
      )
    end
  end

  describe "#paginate" do
    before do
      allow(controller).to receive(:params).and_return(
        ActionController::Parameters.new(
          page: page,
          per_page: per_page
        )
      )

      controller.public_send(:set_pagination_params)
    end

    context "when page is provided" do
      let(:page) { "2" }
      let(:per_page) { "2" }

      it "returns the requested page" do
        result = controller.paginate(Movie.all)

        expect(result[:data].map(&:title)).to eq([ "Movie 3", "Movie 4" ])
      end

      it "returns pagination metadata" do
        result = controller.paginate(Movie.all)

        expect(result[:pagination]).to eq(
                                         page: 2,
                                         per_page: 2,
                                         pages: 3,
                                         total: 5
                                       )
      end
    end

    context "when page is not provided" do
      let(:page) { nil }
      let(:per_page) { nil }

      it "returns the collection wrapped in data" do
        expect(controller.paginate(Movie.all)).to eq(data: Movie.all)
      end
    end

    context "when per_page is not provided" do
      let(:page) { "1" }
      let(:per_page) { nil }

      it "uses the default per_page" do
        result = controller.paginate(Movie.all)

        expect(result[:pagination][:per_page]).to eq(Pagination::PER_PAGE)
      end
    end

    context "when per_page is greater than the maximum" do
      let(:page) { "1" }
      let(:per_page) { "101" }

      it "uses the maximum per_page" do
        result = controller.paginate(Movie.all)

        expect(result[:pagination][:per_page]).to eq(Pagination::MAX_PER_PAGE)
      end
    end

    context "when page is less than 1" do
      let(:page) { "0" }
      let(:per_page) { "2" }

      it "uses page 1" do
        result = controller.paginate(Movie.all)

        expect(result[:pagination][:page]).to eq(1)
        expect(result[:data].map(&:title)).to eq([ "Movie 1", "Movie 2" ])
      end
    end
  end
end
