# frozen_string_literal: true

FactoryBot.define do
  factory :campsite do
    name { Faker::Games::SuperSmashBros.stage }
  end
end
