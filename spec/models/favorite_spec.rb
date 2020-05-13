require 'rails_helper'

describe Favorite do
  describe "#total_count" do
    it "can calculate the total number of favorites it holds" do
      favorite = Favorite.new(1)
      expect(favorite.total_count).to eq(1)
      favorite.add_pet(2)
      expect(favorite.total_count).to eq(2)
    end
  end

  describe "#add_pet" do
    it "adds a pet to its contents" do
      shelter = Shelter.create({name: "Happy Shelter",
                               address: "12980 Grover Drive",
                               city: "Doggy Vale",
                               state: "Colorado",
                               zip: 74578})

      pet = Pet.create({
        image: "Happy Url",
        name: "Raulgh",
        approximate_age: 27,
        sex: "Male",
        shelter_id: shelter.id
        })
        pet2 = shelter.pets.create(image: "cute.jpg", name: "Spot", approximate_age: 2, sex: "Male", description: "Spotted Puppy!")
      favorite = Favorite.new(pet)
      expect(favorite.contents).to eq([pet])
      favorite.add_pet(pet2)
      expect(favorite.contents).to eq([pet, pet2])
    end
  end
end
