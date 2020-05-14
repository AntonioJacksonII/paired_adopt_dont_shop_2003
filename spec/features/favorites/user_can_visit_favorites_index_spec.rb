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
end
