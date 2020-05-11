require 'rails_helper'

RSpec.describe "Shelter Index Page", type: :feature do
  it "Can click on name of shelter and go to shelter show page" do

    shelter = Shelter.create(name: "Kitty Shelter",
                             address: "12888 Kitty Drive",
                             city: "Kitty Vale",
                             state: "Kitty Twon",
                             zip: 73429)

   pet_1 = Pet.create({
     image: "pet_url_1",
     name: "Sparky",
     approximate_age: 5,
     sex: "Male",
     shelter_id: shelter.id,
     description: "Cute Puppy with black and white fur",
     adoption_status: "Adoptable"
     })

    visit '/shelters'
    click_link(shelter.name)
    expect(page).to have_content(shelter.name)
    expect(page).to have_content(shelter.address)
    expect(page).to have_content(shelter.city)
    expect(page).to have_content(shelter.state)
    expect(page).to have_content(shelter.zip)
    visit '/pets'
    click_link(shelter.name)
    expect(current_path).to eql("/shelters/#{shelter.id}")
    expect(page).to have_content(shelter.name)
    expect(page).to have_content(shelter.address)
    expect(page).to have_content(shelter.city)
    expect(page).to have_content(shelter.state)
    expect(page).to have_content(shelter.zip)
  end
end
