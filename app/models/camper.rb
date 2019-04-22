class Camper < ApplicationRecord
  belongs_to :campsite
  has_many :supplies

  validates :name, presence: true
end
