# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Lists", type: :request do
  let!(:list) { List.create!(name: "My List") }

  let!(:tv_show) do
    TvShow.create!(
      title: "Test Show",
      original_title: "Test Show",
      year: 2020
    )
  end

  let!(:season) do
    Season.create!(
      title: "The Beginning",
      original_title: "The Beginning",
      year: 2020,
      position: 1,
      tv_show: tv_show
    )
  end

  let!(:movie) do
    Movie.create!(
      title: "Alien",
      original_title: "Alien",
      year: 1979
    )
  end

  let!(:episode) do
    Episode.create!(
      title: "Pilot",
      original_title: "Pilot",
      year: 2020,
      position: 1,
      season: season
    )
  end

  before do
    list.content_lists.create!(content: movie, position: 1)
    list.content_lists.create!(content: season, position: 2)
    list.content_lists.create!(content: episode, position: 3)
    list.content_lists.create!(content: tv_show, position: 4)
  end

  describe "GET /lists/:id" do
    it "returns the list and its contents" do
      get "/lists/#{list.id}"

      expect(response).to have_http_status(:ok)

      expect(JSON.parse(response.body)).to match(
                                             "list" => {
                                               "name" => "My List",
                                               "contents" => {
                                                 "data" => [
                                                   hash_including(
                                                     "title" => "Alien",
                                                     "type" => "movie"
                                                   ),
                                                   hash_including(
                                                     "title" => "The Beginning",
                                                     "type" => "season",
                                                     "number" => "Season 1"
                                                   ),
                                                   hash_including(
                                                     "title" => "Pilot",
                                                     "type" => "episode",
                                                     "number" => "Episode 1"
                                                   ),
                                                   hash_including(
                                                     "title" => "Test Show",
                                                     "type" => "tv_show"
                                                   )
                                                 ]
                                               }
                                             }
                                           )
    end

    it "preserves list order" do
      get "/lists/#{list.id}"

      contents = JSON.parse(response.body)["list"]["contents"]["data"]

      expect(contents.map { |content| content["title"] }).to eq([ "Alien", "The Beginning", "Pilot", "Test Show" ])
    end

    it "filters by content type" do
      get "/lists/#{list.id}", params: { content_type: "movie" }

      expect(response).to have_http_status(:ok)

      contents = JSON.parse(response.body)["list"]["contents"]["data"]

      expect(contents.size).to eq(1)
      expect(contents.first["type"]).to eq("movie")
    end

    context "when content type has an underscore" do
      it "filters by content type correctly" do
        get "/lists/#{list.id}", params: { content_type: "tv_show" }

        expect(response).to have_http_status(:ok)

        contents = JSON.parse(response.body)["list"]["contents"]["data"]

        expect(contents.size).to eq(1)
        expect(contents.first["type"]).to eq("tv_show")
      end
    end

    it "rejects an invalid content type" do
      get "/lists/#{list.id}", params: { content_type: "banana" }

      expect(response).to have_http_status(:bad_request)

      json = JSON.parse(response.body)

      expect(json["error"]).to eq("Valid content_types: tv_show, movie, season, episode")
    end

    it "paginates when page is provided" do
      get "/lists/#{list.id}", params: { page: 2 }

      expect(response).to have_http_status(:ok)

      contents = JSON.parse(response.body)["list"]["contents"]

      expect(contents["data"].size).to eq(1)
      expect(contents["pagination"]).to eq(
                                          "page" => 2,
                                          "per_page" => 3,
                                          "pages" => 2,
                                          "total" => 4
                                        )
    end

    it "respects per_page" do
      get "/lists/#{list.id}", params: {
        page: 1,
        per_page: 2
      }

      contents = JSON.parse(response.body)["list"]["contents"]

      expect(contents["data"].size).to eq(2)
      expect(contents["pagination"]["page"]).to eq(1)
      expect(contents["pagination"]["per_page"]).to eq(2)
      expect(contents["pagination"]["pages"]).to eq(2)
      expect(contents["pagination"]["total"]).to eq(4)
    end
  end
end
