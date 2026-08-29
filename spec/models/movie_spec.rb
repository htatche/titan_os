# frozen_string_literal: true

require "rails_helper"

RSpec.describe Movie, type: :model do
  describe "associations" do
    it { is_expected.to have_many(:content_lists) }
    it { is_expected.to have_many(:lists).through(:content_lists) }
  end
end
