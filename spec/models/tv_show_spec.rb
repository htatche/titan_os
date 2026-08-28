# frozen_string_literal: true

require "rails_helper"

RSpec.describe TvShow, type: :model do
  describe "associations" do
    it { is_expected.to have_many(:seasons).dependent(:destroy) }
    it { is_expected.to have_many(:episodes).through(:seasons) }
    it { is_expected.to have_many(:content_lists) }
    it { is_expected.to have_many(:lists).through(:content_lists) }
  end
end