require 'rails_helper'

describe "Favoirtes index page", type: :feature do
  it "can unfavorite pets from index page" do
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
      expect(current_path).to eql("/pets/#{pet.id}")
      expect(page).to have_content("Favorite Pets: 1")
      expect(page).not_to have_button("Favorite This Pet")
      visit "/favorites"
      within "#favorite-#{pet.id}" do
      expect(page).to have_content(pet.name)
      expect(page).to have_content(pet.image)
      end
      click_button("Unfavorite This Pet")
      expect(current_path).to eql("/favorites")

      
      expect(page).not_to have_content(pet.image)

      expect(page).to have_content("Favorite Pets: 0")
    end
    end




  # As a visitor
  # When I have added pets to my favorites list
  # And I visit my favorites page ("/favorites")
  # Next to each pet, I see a button or link to remove that pet from my favorites
  # When I click on that button or link to remove a favorite
  # A delete request is sent to "/favorites/:pet_id"
  # And I'm redirected back to the favorites page where I no longer see that pet listed
  # And I also see that the favorites indicator has decremented by 1
