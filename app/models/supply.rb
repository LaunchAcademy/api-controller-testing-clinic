class Supply < ApplicationRecord
  belongs_to :camper

  validates :name, presence: true
end
