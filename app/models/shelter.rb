class Shelter < ApplicationRecord
  has_many :pets
  has_many :reviews
  validates_presence_of :name, :address, :city, :state, :zip


  def count_of_pets
    pets.count
  end

  def average_rating
    review_rating = reviews.average(:rating)
    if review_rating != nil
      review_rating.round(1)
    end
  end

  def number_of_applications

    pets.count do |pet|
      pet.applications
    end
  end
end
