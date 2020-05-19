require 'rails_helper'

RSpec.describe "shelter delete page", type: :feature do
  it "can delete shelters" do
    shelter = Shelter.create(name: "Fido Shelter",
                             address: "12888 Grover Drive",
                             city: "Dody Vale",
                             state: "Dog Twon",
                             zip: 74599)

  visit("/shelters/#{shelter.id}")
  expect(page).to have_content(shelter.name)
  click_link('Delete Shelter')
  expect(current_path).to_not have_content("/shelters/#{shelter.id}")
  expect(current_path).to have_content("/shelters")
  expect(page).not_to have_content(shelter.name)
  expect(page).not_to have_content(shelter.address)
  expect(page).not_to have_content(shelter.city)
  expect(page).not_to have_content(shelter.state)
  expect(page).not_to have_content(shelter.zip)
end

  it "can't delete shelters if the shelter's pets have an approved application" do
    shelter = Shelter.create(name: "Fido Shelter",
                             address: "12888 Grover Drive",
                             city: "Dody Vale",
                             state: "Dog Twon",
                             zip: 74599)
    shelter2 = Shelter.create({name: "Happy Shelter",
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

     application1.pets << pet1
     visit "/applications/#{application1.id}"
     within ".pet-#{pet1.id}" do
       click_link("Approve Pet")
     end

     visit "/shelters"
     within("#shelter-#{shelter.id}") do
       expect(page).to_not have_link("Delete Shelter")
     end

     within("#shelter-#{shelter2.id}") do
       click_link("Delete Shelter")
     end
     expect(current_path).to eq("/shelters")
     expect(page).to_not have_content("Happy Shelter")

     visit "/shelters/#{shelter.id}"
     expect(page).to_not have_link("Delete Shelter")
  end
end
