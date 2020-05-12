require 'rails_helper'

describe "Navigation Bar", type: :feature do
  it "displays a favorite indicator showing count of favorite pets on every page" do
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
    review_1 = Review.create(title: "Great Shelter",
                             rating: 5,
                             content: "Awesome experience",
                             shelter_id: shelter.id)

    visit "/shelters"
    expect(page).to have_content("Favorite Pets: 0")
    visit "/shelters/#{shelter.id}"
    expect(page).to have_content("Favorite Pets: 0")
    visit '/shelters/new'
    expect(page).to have_content("Favorite Pets: 0")
    visit "/shelters/#{shelter.id}/edit"
    expect(page).to have_content("Favorite Pets: 0")
    visit "/pets/#{pet.id}"
    expect(page).to have_content("Favorite Pets: 0")
    visit "/shelters/#{shelter.id}/pets"
    expect(page).to have_content("Favorite Pets: 0")
    visit "/shelters/#{shelter.id}/pets/new"
    expect(page).to have_content("Favorite Pets: 0")
    visit "/pets/#{pet.id}/edit"
    expect(page).to have_content("Favorite Pets: 0")
    visit "/shelters/#{shelter.id}/reviews/#{review_1.id}/edit"
    expect(page).to have_content("Favorite Pets: 0")
    visit "/shelters/#{shelter.id}/reviews/new"
    expect(page).to have_content("Favorite Pets: 0")
    visit "/pets"
    expect(page).to have_content("Favorite Pets: 0")
  end
end
