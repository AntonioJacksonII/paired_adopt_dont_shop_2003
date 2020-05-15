require 'rails_helper'

describe 'Application Form', type: :feature do
  xit 'can link to application from Favorites page' do
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
    pet2 = shelter.pets.create(image: "cute.jpg", name: "Spot", approximate_age: 2, sex: "Male", description: "Spotted Puppy!")
    visit "/pets/#{pet2.id}"
    click_button("Favorite This Pet")
    visit "/favorites"
    click_link "Adopt Your Favorites"
    expect(current_path).to eq("/applications/new")
  end
end
