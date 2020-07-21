FactoryBot.define do
  factory :camper do
    name  { Faker::Games::SuperSmashBros.fighter }
    campsite
  end
end
