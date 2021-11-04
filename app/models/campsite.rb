class Campsite < ApplicationRecord
  has_many :campers

  validates :name, presence: true
end
