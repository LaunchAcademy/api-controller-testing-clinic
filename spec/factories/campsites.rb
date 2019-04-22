# frozen_string_literal: true

FactoryBot.define do
  factory :campsite do
    name { Faker::TvShows::TwinPeaks.location }
  end
end
