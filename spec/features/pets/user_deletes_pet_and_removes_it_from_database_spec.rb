require "rails_helper"

RSpec.describe "Pet Show Page", type: :feature do
  it "Removes pet from favorites upon deletion" do
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
      visit "/favorites"

      within ".favorite-#{pet.id}" do
        expect(page).to have_content(pet.name)
      end
      visit "/pets/#{pet.id}"
      click_link("Delete Pet")
      visit '/favorites'
      expect(page).not_to have_css(".favorite-#{pet.id}")
      
  end
end
