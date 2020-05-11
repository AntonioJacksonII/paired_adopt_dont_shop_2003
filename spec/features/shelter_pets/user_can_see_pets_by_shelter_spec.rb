require 'rails_helper'

RSpec.describe "Shelters Pets Index Page", type: :feature do
  it "Can Show Pets by Shelter" do

    shelter_1 = Shelter.create({name: "Happy Shelter",
                             address: "12980 Grover Drive",
                             city: "Doggy Vale",
                             state: "Colorado",
                             zip: 74578})

   pet_1 = Pet.create({
     image: "pet_url_1",
     name: "Sparky",
     approximate_age: 5,
     sex: "Male",
     shelter_id: shelter_1.id

     })

   pet_2 = Pet.create({
     image: "pet_url_2",
     name: "Silly",
     approximate_age: 2,
     sex: "Female",
     shelter_id: shelter_1.id
     })

     visit "/shelters/#{shelter_1.id}/pets"
     expect(current_path).to eql("/shelters/#{shelter_1.id}/pets")
     expect(page).to have_content(pet_1.image)
     expect(page).to have_content(pet_1.name)
     expect(page).to have_content(pet_1.approximate_age)
     expect(page).to have_content(pet_1.sex)
     expect(page).to have_content(pet_2.image)
     expect(page).to have_content(pet_2.name)
     expect(page).to have_content(pet_2.approximate_age)
     expect(page).to have_content(pet_2.sex)

   end
 end
