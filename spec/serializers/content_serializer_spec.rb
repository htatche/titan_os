# frozen_string_literal: true

require "rails_helper"

RSpec.describe ContentSerializer do
  describe "#as_json" do
    context "with a movie" do
      let(:movie) do
        Movie.create!(
          title: "Alien",
          original_title: "Alien",
          year: 1979
        )
      end

      subject(:json) { described_class.new(movie).as_json }

      it "serializes the movie" do
        expect(json).to eq(
                          title: "Alien",
                          original_title: "Alien",
                          year: 1979,
                          type: "movie"
                        )
      end
    end

    context "with a season" do
      let(:season) do
        Season.create!(
          title: "The Beginning",
          original_title: "The Beginning",
          year: 2020,
          position: 1,
          tv_show: TvShow.create!(
            title: "Test Show",
            original_title: "Test Show",
            year: 2020
          )
        )
      end

      subject(:json) { described_class.new(season).as_json }

      it "includes the season number" do
        expect(json[:number]).to eq(1)
      end
    end

    context "with an episode" do
      let(:episode) do
        Episode.create!(
          title: "Pilot",
          original_title: "Pilot",
          year: 2020,
          position: 3,
          season: Season.create!(
            title: "The Beginning",
            original_title: "The Beginning",
            year: 2020,
            position: 1,
            tv_show: TvShow.create!(
              title: "Test Show",
              original_title: "Test Show",
              year: 2020
            )
          )
        )
      end

      subject(:json) { described_class.new(episode).as_json }

      it "includes the episode number" do
        expect(json[:number]).to eq(3)
      end
    end
  end
end
