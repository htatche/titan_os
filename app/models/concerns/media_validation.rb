# frozen_string_literal: true

module MediaValidation
  START_OF_SCREEN_ERA = 1800

  extend ActiveSupport::Concern

  included do
    validates :title, :original_title, presence: true
    # Movies and TV started in the late 1800's, early 1900's respectively
    validates :year, numericality: { in: (START_OF_SCREEN_ERA..Date.today.year + 5) }

    def season?
      self.is_a?(Season)
    end

    def episode?
      self.is_a?(Episode)
    end
  end
end
