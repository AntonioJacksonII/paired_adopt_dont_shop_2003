require 'rails_helper'

RSpec.describe "Pet Index Page", type: :feature do
  it "Can click pet name and go to pet show page" do

    shelter = Shelter.create(name: "Kitty Shelter",
                             address: "12888 Kitty Drive",
                             city: "Kitty Vale",
                             state: "Kitty Twon",
                             zip: 73429)

    pet = Pet.create({
     image: "pet_url_1",
     name: "Spark",
     approximate_age: 5,
     sex: "Male",
     shelter_id: shelter.id,
     description: "Cute Puppy with black and white fur",
     adoption_status: "Adoptable"
     })

     visit "/pets"
     click_link("#{pet.name}")
     expect(current_path).to eql("/pets/#{pet.id}")
     expect(page).to have_content(pet.image)
     expect(page).to have_content(pet.name)
     expect(page).to have_content(pet.approximate_age)
     expect(page).to have_content(pet.sex)
     visit "/shelters/#{shelter.id}/pets"
     click_link("#{pet.name}")
     expect(page).to have_content(pet.image)
     expect(page).to have_content(pet.name)
     expect(page).to have_content(pet.approximate_age)
     expect(page).to have_content(pet.sex)

  end
end
