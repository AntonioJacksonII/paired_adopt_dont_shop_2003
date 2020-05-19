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
     visit "/pets/#{pet1.id}"
     click_button("Favorite This Pet")
     visit "/pets/#{pet2.id}"
     click_button("Favorite This Pet")
     visit "/applications/new"

     check "#{pet1.id}"

     fill_in :name, with: "Applicant A"
     fill_in :address, with: "123 A St"
     fill_in :city, with: "Fake"
     fill_in :state, with: "CO"
     fill_in :zip, with: "80202"
     fill_in :phone, with: "123-456-7891"
     fill_in :description, with: "Clean home"
     click_button("Submit Application")

     visit "/shelters"

     save_and_open_page

     within("#shelter-#{shelter.id}") do
       expect(page).to_not have_link("Delete Shelter")
     end

     within("#shelter-#{shelter2.id}") do
       click_link("Delete Shelter")
     end
     expect(current_path).to eq("/shelters")
     expect(page).to_not have_content("Happy Shelter")
  end
end
