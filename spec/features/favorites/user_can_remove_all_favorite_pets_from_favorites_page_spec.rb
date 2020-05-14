require 'rails_helper'

RSpec.describe 'Favorites Index Page', type: :feature do

  it "Can delete all favortes from favorites index page" do



  shelter = Shelter.create({name: "Happy Shelter",
                           address: "12980 Grover Drive",
                           city: "Doggy Vale",
                           state: "Colorado",
                           zip: 74578})

  pet_1 = Pet.create({
    image: "Happy Url",
    name: "Raulgh",
    approximate_age: 27,
    sex: "Male",
    shelter_id: shelter.id
    })

  pet_2 = Pet.create({
    image: "Freddy Url",
    name: "Freddy",
    approximate_age: 30,
    sex: "Male",
    shelter_id: shelter.id
    })

    visit "/pets/#{pet_1.id}"
    click_on ("Favorite This Pet")
    visit "/pets/#{pet_2.id}"
    click_on ("Favorite This Pet")
    visit "/favorites"
    expect(page).to have_css("#favorite-#{pet_1.id}")
    expect(page).to have_css("#favorite-#{pet_2.id}")
    within "#favorite-#{pet_1.id}" do
      expect(page).to have_content(pet_1.name)
    end
    within "#favorite-#{pet_2.id}" do
      expect(page).to have_content(pet_2.name)
    end
    click_link "Remove All Favorited Pets"
    expect(current_path).to eql("/favorites")
    expect(page).to have_content("You Have No More Favorite Pets")
    expect(page).to have_content("Favorite Pets: 0")
    expect(page).not_to have_css("#favorite-#{pet_1.id}")
    expect(page).not_to have_css("#favorite-#{pet_2.id}")
end

it "Does not have Remove all Pets link from favorites if there is no favorites" do
  shelter = Shelter.create({name: "Happy Shelter",
                           address: "12980 Grover Drive",
                           city: "Doggy Vale",
                           state: "Colorado",
                           zip: 74578})

  pet_1 = Pet.create({
    image: "Happy Url",
    name: "Raulgh",
    approximate_age: 27,
    sex: "Male",
    shelter_id: shelter.id
    })

  pet_2 = Pet.create({
    image: "Freddy Url",
    name: "Freddy",
    approximate_age: 30,
    sex: "Male",
    shelter_id: shelter.id
    })

    visit "/favorites"
    expect(page).not_to have_link("Remove All Favorited Pets")

end
end


# As a visitor
# When I have added pets to my favorites list
# And I visit my favorites page ("/favorites")
# I see a link to remove all favorited pets
# When I click that link
# I'm redirected back to the favorites page
# I see the text saying that I have no favorited pets
# And the favorites indicator returns to 0
