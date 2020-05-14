class Pet < ApplicationRecord
  belongs_to :shelter
  validates_presence_of :image, :name, :approximate_age, :sex
  has_many :application_pets
  has_many :applications, through: :application_pets
end
