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

  it "lists favorite pets user can select at the top of the page" do
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

   expect(page).to have_content("Garfield")
   expect(page).to have_content("Spot")
   check "#{pet1.id}"
   check "#{pet2.id}"
 end

  it "successfully submits an application and displays a message" do
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

    check "#{pet1.id}"

    fill_in :name, with: "Applicant A"
    fill_in :address, with: "123 A St"
    fill_in :city, with: "Fake"
    fill_in :state, with: "CO"
    fill_in :zip, with: "80202"
    fill_in :phone, with: "123-456-7891"
    fill_in :description, with: "Clean home"
    click_button("Submit Application")

    expect(current_path).to eq("/favorites")
    expect(page).to have_content("Your application was submitted!")
    expect(page).to_not have_content("Garfield")
    expect(page).to have_content("Spot")
  end
end
