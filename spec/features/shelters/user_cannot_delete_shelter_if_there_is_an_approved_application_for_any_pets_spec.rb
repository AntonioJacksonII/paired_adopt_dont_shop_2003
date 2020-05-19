require "rails_helper"

RSpec.describe "Shelter Show Page", type: :feature do
  it "Can not delete shelter if it has any approved applications for any pets" do
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

    application1 = Application.create({
        name: "Bob",
        address: "222 Bob Road",
        city: "Bob City",
        state: "Bob State",
        zip: "39233",
        phone: "30332432",
        description: "Love, pets have lots of space for them"
      })

    application1.pets << pet


      visit "applications/#{application1.id}"
      within ".pet-#{pet.id}" do
      click_link("Approve Pet")
      end
      visit "/shelters/#{shelter.id}"
      expect(page).not_to have_link("Delete Shelter")



  end
end

# As a visitor
# If a shelter has approved applications for any of their pets
# I can not delete that shelter
# Either:
# - there is no button visible for me to delete the shelter
# - if I click on the delete link for deleting a
#   shelter, I see a flash message indicating that the shelter can not be deleted.
