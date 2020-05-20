require 'rails_helper'

RSpec.describe "Pets Index Page", type: :feature do
  it "can update pet info form pet index page" do

    shelter = Shelter.create(name: "Curls Shelter",
                             address: "12888 Curl Drive",
                             city: "Curl Vale",
                             state: "Curl Twon",
                             zip: 73459)

    pet = Pet.create({
      image: "pet_url_1",
      name: "Sparky",
      approximate_age: 5,
      sex: "Male",
      shelter_id: shelter.id,
      description: "Cute Puppy with black and white fur",
      adoption_status: "Adoptable"
      })

    visit '/pets'
    click_link("Update Pet #{pet.id}")
    fill_in :image, with: "Curls Url"
    fill_in :name, with: "Curls"
    fill_in :description, with: "A curly pet"
    fill_in :approximate_age, with: 22
    fill_in :sex, with: "Female"
    click_on 'Update Pet'
    expect(current_path).to eql("/pets/#{pet.id}")
    expect(page).to have_content("Curls Url")
    expect(page).to have_content("Curls")
    expect(page).to have_content(22)
    expect(page).to have_content("Female")

    visit "/shelters/#{shelter.id}/pets"
    expect(current_path).to eql ("/shelters/#{shelter.id}/pets")
    click_link("Update Pet #{pet.id}")
    fill_in :image, with: "Spiky Url"
    fill_in :name, with: "Spiky"
    fill_in :description, with: "A spiky pet"
    fill_in :approximate_age, with: 23
    fill_in :sex, with: "Male"
    click_on 'Update Pet'
    expect(current_path).to eql("/pets/#{pet.id}")
    expect(page).to have_content("Spiky Url")
    expect(page).to have_content("Spiky")
    expect(page).to have_content(23)
    expect(page).to have_content("Male")
  end

  it "can display error message when forms are not filled out completely" do

    shelter = Shelter.create(name: "Curls Shelter",
                             address: "12888 Curl Drive",
                             city: "Curl Vale",
                             state: "Curl Twon",
                             zip: 73459)

    pet = Pet.create({
      image: "pet_url_1",
      name: "Sparky",
      approximate_age: 5,
      sex: "Male",
      shelter_id: shelter.id,
      description: "Cute Puppy with black and white fur",
      adoption_status: "Adoptable"
      })

    visit '/pets'
    click_link("Update Pet #{pet.id}")

    fill_in :image, with: ""
    click_on "Update Pet"
    expect(current_path).to eq("/pets/#{pet.id}/edit")
    expect(page).to have_content("Please fill in image")

    fill_in :name, with: ""
    click_on "Update Pet"
    expect(current_path).to eq("/pets/#{pet.id}/edit")
    expect(page).to have_content("Please fill in name")


    fill_in :description, with: ""
    fill_in :name, with: ""
    click_on "Update Pet"
    expect(current_path).to eq("/pets/#{pet.id}/edit")
    expect(page).to have_content("Please fill in name, description")

    fill_in :approximate_age, with: ""
    click_on "Update Pet"
    expect(current_path).to eq("/pets/#{pet.id}/edit")
    expect(page).to have_content("Please fill in approximate age")


    fill_in :sex, with: ""
    click_on 'Update Pet'
    expect(current_path).to eq("/pets/#{pet.id}/edit")
    expect(page).to have_content("Please fill in sex")

    fill_in :sex, with: "female"
    click_on 'Update Pet'
    expect(current_path).to eq("/pets/#{pet.id}")
  end
end
