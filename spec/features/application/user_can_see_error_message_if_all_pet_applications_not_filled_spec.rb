require 'rails_helper'

RSpec.describe "Application Form", type: :feature do
  it "Can Display error message when form is not filled out completely" do
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
        visit "/applications/new"
        check "#{pet2.id}"
        fill_in :name, with: "Applicant A"
        fill_in :address, with: "123 A St"
        fill_in :city, with: "Fake"
        fill_in :state, with: "CO"
        click_button("Submit Application")
        expect(current_path).to eql("/applications/new")
        expect(page).to have_content("Please, fill in all the forms below to submit")
        fill_in :address, with: "123 A St"
        fill_in :city, with: "Fake"
        fill_in :state, with: "CO"
        fill_in :zip, with: "80202"
        fill_in :phone, with: "123-456-7891"
        fill_in :description, with: "Clean home"
        expect(current_path).to eql("/applications/new")
        expect(page).to have_content("Please, fill in all the forms below to submit")
  end

  it "Gives an error message if no pets are favorited" do
    shelter = Shelter.create({name: "Happy Shelter",
                          address: "12980 Grover Drive",
                          city: "Doggy Vale",
                          state: "Colorado",
                          zip: 74578})
<<<<<<< HEAD

    pet1 = shelter.pets.create(image: "cat.jpg", name: "Garfield", approximate_age: 1, sex: "Male", description: "Cute cat!")
=======
                          pet1 = shelter.pets.create(image: "cat.jpg", name: "Garfield", approximate_age: 1, sex: "Male", description: "Cute cat!")
>>>>>>> master
    pet2 = shelter.pets.create(image: "cute.jpg", name: "Spot", approximate_age: 2, sex: "Male", description: "Spotted Puppy!")
    visit "/pets/#{pet1.id}"
    click_button("Favorite This Pet")
    visit "/pets/#{pet2.id}"
    click_button("Favorite This Pet")
    visit "/applications/new"
    fill_in :name, with: "Applicant A"
    fill_in :address, with: "123 A St"
    fill_in :city, with: "Fake"
    fill_in :state, with: "CO"
    fill_in :zip, with: "80202"
    fill_in :phone, with: "123-456-7891"
    fill_in :description, with: "Clean home"
    click_button("Submit Application")
    expect(current_path).to eql("/applications/new")
    expect(page).to have_content("Please, fill in all the forms below to submit")
  end
end
