require 'rails_helper'

RSpec.describe "Pet Index Page", type: :feature do
  it "Can See All Pets" do

    shelter_1 = Shelter.create({name: "Happy Shelter",
                             address: "12980 Grover Drive",
                             city: "Doggy Vale",
                             state: "Colorado",
                             zip: 74578})

   shelter_2 = Shelter.create({name: "Doggy Haven",
                            address: "22222 Haven Street",
                            city: "Doggy Vale",
                            state: "California",
                            zip: 86192})




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
      shelter_id: shelter_2.id

      })


  visit "/pets"
  expect(page).to have_content(pet_1.image)
  expect(page).to have_content(pet_1.name)
  expect(page).to have_content(pet_1.approximate_age)
  expect(page).to have_content(pet_1.shelter.name)
  expect(page).to have_content(pet_1.sex)
  expect(page).to have_content(pet_2.image)
  expect(page).to have_content(pet_2.name)
  expect(page).to have_content(pet_2.approximate_age)
  expect(page).to have_content(pet_2.sex)
  expect(page).to have_content(pet_2.shelter.name)
  

  end
end
