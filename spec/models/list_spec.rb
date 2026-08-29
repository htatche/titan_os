# frozen_string_literal: true

require "rails_helper"

RSpec.describe List, type: :model do
  describe "associations" do
    it { is_expected.to have_many(:content_lists) }

    it do
      is_expected.to have_many(:tv_shows).through(:content_lists)
    end

    it do
      is_expected.to have_many(:movies).through(:content_lists)
    end

    it do
      is_expected.to have_many(:seasons).through(:content_lists)
    end

    it do
      is_expected.to have_many(:episodes).through(:content_lists)
    end
  end

  describe "validations" do
    it { is_expected.to validate_length_of(:name).is_at_most(100) }
  end
end
