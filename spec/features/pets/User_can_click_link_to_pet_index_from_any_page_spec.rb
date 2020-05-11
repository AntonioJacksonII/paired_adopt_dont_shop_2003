require 'rails_helper'

RSpec.describe "Pet Index Page", type: :feature do
  it "Can click link from any page and go to Pet Index Page" do

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

    visit "/shelters"
    click_link("See All Pets")
    expect(current_path).to eql("/pets")
    visit "/shelters/#{shelter.id}"
    click_link("See All Pets")
    expect(current_path).to eql("/pets")
    visit '/shelters/new'
    click_link("See All Pets")
    expect(current_path).to eql("/pets")
    visit "shelters/#{shelter.id}/edit"
    click_link("See All Pets")
    expect(current_path).to eql("/pets")
    visit "/pets/#{pet.id}"
    click_link("See All Pets")
    expect(current_path).to eql("/pets")
    visit "/shelters/#{shelter.id}/pets"
    click_link("See All Pets")
    expect(current_path).to eql("/pets")
    visit "shelters/#{shelter.id}/pets/new"
    click_link("See All Pets")
    expect(current_path).to eql("/pets")
    visit "pets/#{pet.id}/edit"
    click_link("See All Pets")
    expect(current_path).to eql("/pets")
  end
end
