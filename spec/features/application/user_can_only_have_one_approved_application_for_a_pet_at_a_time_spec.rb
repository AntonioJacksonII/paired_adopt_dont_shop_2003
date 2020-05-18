require "rails_helper"

RSpec.describe "Applications show page", type: :feature do
  it "Can only approve one pet at a time" do
    shelter = Shelter.create({name: "Happy Shelter",
                          address: "12980 Grover Drive",
                          city: "Doggy Vale",
                          state: "Colorado",
                          zip: 74578})

    pet1 = shelter.pets.create(image: "cat.jpg", name: "Garfield", approximate_age: 1, sex: "Male", description: "Cute cat!")
    pet2 = shelter.pets.create(image: "cute.jpg", name: "Spot", approximate_age: 2, sex: "Male", description: "Spotted Puppy!")

    application1 = Application.create({
        name: "Bob",
        address: "222 Bob Road",
        city: "Bob City",
        state: "Bob State",
        zip: "39233",
        phone: "30332432",
        description: "Love, pets have lots of space for them"
      })

    application2 = Application.create({
      name: "Jim",
      address: "222 Jim Road",
      city: "Jim City",
      state: "Jim State",
      zip: "33233",
      phone: "30336532",
      description: "friendly family"
      })
      application1.pets << pet1
      application2.pets << pet1
      application1.pets << pet2
      visit "/applications/#{application1.id}"
      within "pet-#{pet1.id}" do
      click_link "Approve Pet"
      end
      visit "/applications/#{application1.id}"
      within "pet-#{pet2.id}" do
        expect(page).not_to have_content("Approve Pet")
      end
      visit "/pet/#{pet1.id}/applications"
      within "applicant-#{application1.id}" do
      expect(page).to have_content(application1.name)
      end
      within "applicant-#{application2.id}" do
        expect(page).to have_content(application2.name)
      end
  end
end








# As a visitor
# When a pet has more than one application made for them
# And one application has already been approved for them
# I can not approve any other applications for that pet but all other applications
#  still remain on file (they can be seen on the pets application index page)
# (This can be done by either taking away the option
#   to approve the application, or having a flash message pop up
#   saying that no more applications can be approved for this pet at this time)
