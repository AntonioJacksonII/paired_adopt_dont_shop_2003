require 'rails_helper'

describe 'Navigation Bar', type: :feature do
  it "links to the favorites index when user clicks favorite indicator" do
    visit '/shelters'
    click_link 'Favorite Pets: 0'

    expect(current_path).to eq('/favorites')
  end
end

describe 'Favorites Index Page', type: :feature do
  it "displays all pets a user has favorited" do
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
    click_link("Favorite Pets: 2")
    expect(page).to have_link("Raulgh")
    expect(page).to have_link("Spot")
    expect(page).to have_content("cute.jpg")
    expect(page).to have_content("Happy Url")
    click_link("Spot")
    expect(current_path).to eq("/pets/#{pet2.id}")
  end

  it "tells a user when they have no favorited pets" do
    visit '/favorites'
    expect(page).to have_content("You have no favorite pets.")
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
    click_link("Favorite Pets: 1")
    expect(page).to_not have_content("You have no favorite pets.")
  end

  it "displays a section with all of the pets with applications on them" do
    visit "/favorites"
    shelter = Shelter.create({name: "Happy Shelter",
                             address: "12980 Grover Drive",
                             city: "Doggy Vale",
                             state: "Colorado",
                             zip: 74578})
    pet = shelter.pets.create({
      image: "Happy Url",
      name: "Raulgh",
      approximate_age: 27,
      sex: "Male",
      })
    pet2 = shelter.pets.create(image: "cute.jpg", name: "Spot", approximate_age: 2, sex: "Male", description: "Spotted Puppy!")
    pet3 = shelter.pets.create(image: "kitten.jpg", name: "Luna", approximate_age: 1, sex: "Female", description: "Black kitten")
    visit "/pets/#{pet.id}"
    click_button("Favorite This Pet")
    visit "/pets/#{pet2.id}"
    click_button("Favorite This Pet")
    visit "/pets/#{pet3.id}"
    click_button("Favorite This Pet")
    visit "/favorites"
    click_link("Adopt Your Favorite Pets")

    check "#{pet.id}"
    check "#{pet2.id}"

    fill_in :name, with: "Applicant A"
    fill_in :address, with: "123 A St"
    fill_in :city, with: "Fake"
    fill_in :state, with: "CO"
    fill_in :zip, with: "80202"
    fill_in :phone, with: "123-456-7891"
    fill_in :description, with: "Clean home"
    click_button("Submit Application")

    expect(current_path).to eq("/favorites")
    expect(page).to have_content("Pets With Applications On Them:")

    within "#applicationpet-#{pet.id}" do
      expect(page).to have_link("Raulgh")
    end

    within "#applicationpet-#{pet2.id}" do
      expect(page).to have_link("Spot")
    end

    within "#favorite-#{pet3.id}" do
      expect(page).to have_link("Luna")
    end

    click_link("Raulgh")

    expect(current_path).to eq("/pets/#{pet.id}")
  end
end
