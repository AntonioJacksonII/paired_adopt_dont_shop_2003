class Shelter < ApplicationRecord
  has_many :pets
  has_many :reviews
  validates_presence_of :name, :address, :city, :state, :zip


  def count_of_pets
    Pet.count
  end

  def average_rating
    reviews.average(:rating).round(1)
  end

  def number_of_applications

    pets.count do |pet|
      pet.applications
    end
  end
end
