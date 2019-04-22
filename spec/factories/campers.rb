FactoryBot.define do
  factory :camper do
    name  { Faker::TvShows::TwinPeaks.character }
    campsite
  end
end
