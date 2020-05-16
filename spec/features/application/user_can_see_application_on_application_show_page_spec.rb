require "rails_helper"

RSpec.describe "Application Show Page", type: :feature do
  it "Can display applications information and pets on the applications show page" do
    shelter = Shelter.create({name: "Happy Shelter",
                          address: "12980 Grover Drive",
                          city: "Doggy Vale",
                          state: "Colorado",
                          zip: 74578})

    pet1 = shelter.pets.create(image: "cat.jpg", name: "Garfield", approximate_age: 1, sex: "Male", description: "Cute cat!")
    pet2 = shelter.pets.create(image: "cute.jpg", name: "Spot", approximate_age: 2, sex: "Male", description: "Spotted Puppy!")
    application = Application.create({
        name: "Bob",
        address: "222 Bob Road",
        city: "Bob City",
        state: "Bob State",
        zip: "39233",
        phone: "30332432",
        description: "Love, pets have lots of space for them"
      })
      application.pets << pet1
      application.pets << pet2
      visit "/application/#{application.id}"
      expect(page).to have_content(application.name)
      expect(page).to have_content(application.address)
      expect(page).to have_content(application.city)
      expect(page).to have_content(application.state)
      expect(page).to have_content(applicaton.zip)
      expect(page).to have_content(application.phone)
      expect(page).to have_content(application.description)
      expect(page).to have_content(pet1.name)
      expect(page).to have_content(pet2.name)
      click_on(pet1.name)
      expect(current_path).to eql("/pets/#{pet1.id}")
  end
  it "Does not display other applications on an application Show page" do
    shelter = Shelter.create({name: "Happy Shelter",
                          address: "12980 Grover Drive",
                          city: "Doggy Vale",
                          state: "Colorado",
                          zip: 74578})

    pet1 = shelter.pets.create(image: "cat.jpg", name: "Garfield", approximate_age: 1, sex: "Male", description: "Cute cat!")
    pet2 = shelter.pets.create(image: "cute.jpg", name: "Spot", approximate_age: 2, sex: "Male", description: "Spotted Puppy!")
    pet3 = shelter.pets.create(image: "Mud.jpg", name: "Mud", approximate_age: 1, sex: "Male", description: "Muddy Puppy")
    application = Application.create({
        name: "Bob",
        address: "222 Bob Road",
        city: "Bob City",
        state: "Bob State",
        zip: "39233",
        phone: "30332432",
        description: "Love, pets have lots of space for them"
      })
      application.pets << pet1
      application.pets << pet2
      application1 = Application.create({
          name: "Chris",
          address: "222 Chris Road",
          city: "Chris City",
          state: "Chris State",
          zip: "33233",
          phone: "3033897987",
          description: "Likes pets"
        })
        application1.pets << pet3

      visit "/applications/#{application.id}"
      expect(page).not_to have_content(application1.name)
      expect(page).not_to have_content(pet3.name)
  end
end
# As a visitor
# When I visit an applications show page "/applications/:id"
# I can see the following:
# - name
# - address
# - city
# - state
# - zip
# - phone number
# - Description of why the applicant says they'd be a good home for this pet(s)
# - names of all pet's that this application is for
# (all names of pets should be links to their show page)
