# frozen_string_literal: true

require "rails_helper"

RSpec.describe Episode, type: :model do
  describe "associations" do
    it { is_expected.to belong_to(:season) }
    it { is_expected.to have_many(:content_lists) }
    it { is_expected.to have_many(:lists).through(:content_lists) }
  end

  describe "validations" do
    it { is_expected.to validate_numericality_of(:position).only_integer }
  end
end