# frozen_string_literal: true

FactoryBot.define do
  factory :supply do
    name { Faker::Creature::Cat.breed }
  end
end
