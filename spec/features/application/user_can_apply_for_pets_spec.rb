require 'rails_helper'

describe 'Application Form', type: :feature do
  it 'can link to Application Form from Favorites page' do
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
    click_link "Adopt Your Favorite Pets"
    expect(current_path).to eq("/applications/new")
  end

  it "lists favorite pets to select at the top of the page" do
    shelter = Shelter.create({name: "Happy Shelter",
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

   expect(page).to have_content(pet1.name)
   expect(page).to have_content(pet2.name)
 end
end
