# frozen_string_literal: true

require "rails_helper"

RSpec.describe ContentList, type: :model do
  describe "associations" do
    it { is_expected.to belong_to(:list) }
    it { is_expected.to belong_to(:content) }
  end

  describe "validations" do
    it { is_expected.to validate_numericality_of(:position).only_integer }
  end
end