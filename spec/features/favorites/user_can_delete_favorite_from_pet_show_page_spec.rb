require 'rails_helper'

describe "Pet Show Page", type: :feature do
  it "can not see link to favorite pets if already favorited" do
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
      expect(page).not_to have_button("Favorite This Pet")
    end
  end
