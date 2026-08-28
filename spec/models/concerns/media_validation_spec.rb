# frozen_string_literal: true

require "rails_helper"

RSpec.describe MediaValidation, type: :model do
  subject(:movie) { Movie.new } # rather than using an anonymous class

  describe "validations" do
    it { is_expected.to validate_presence_of(:title) }
    it { is_expected.to validate_presence_of(:original_title) }

    it do
      is_expected.to validate_numericality_of(:year)
                       .is_in(1800..(Date.today.year + 5))
    end
  end
end