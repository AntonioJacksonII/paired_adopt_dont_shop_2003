require 'rails_helper'

describe "Pet Show Page", type: :feature do
  it "can favorite pets" do
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

      visit "/pets/#{pet.id}"
      click_button("Favorite This Pet")
      expect(current_path).to eq("/pets/#{pet.id}")
      expect(page).to have_content("Favorite Pets: 1")

      pet2 = shelter.pets.create(image: "cute.jpg", name: "Spot", approximate_age: 2, sex: "Male", description: "Spotted Puppy!")
      visit "/pets/#{pet2.id}"
      click_button("Favorite This Pet")
      expect(current_path).to eq("/pets/#{pet2.id}")
      expect(page).to have_content("Favorite Pets: 2")
    end

    it "displays a message when a pet is added to favorites list" do
      shelter = Shelter.create({name: "Happy Shelter",
                               address: "12980 Grover Drive",
                               city: "Doggy Vale",
                               state: "Colorado",
                               zip: 74578})
      pet = shelter.pets.create(image: "happy.jpg", name: "Raulgh", approximate_age: 27, sex: "Male", description: "Cute puppy!")

      visit "/pets/#{pet.id}"

      within ("#pet-#{pet.id}") do
        click_button "Favorite This Pet"
      end

      expect(page).to have_content("You have added Raulgh to your favorites!")

    end
  end
