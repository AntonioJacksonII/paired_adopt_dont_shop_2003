'rails_helper'

RSpec.describe "Pet Creation Page", type: :feature do
  it "can create a pet" do
    shelter = Shelter.create({name: "Happy Shelter",
                             address: "12980 Grover Drive",
                             city: "Doggy Vale",
                             state: "Colorado",
                             zip: 74578})


    visit "/shelters/#{shelter.id}/pets"
    click_link('Create Pet')
    expect(current_path).to eql("/shelters/#{shelter.id}/pets/new")
    fill_in :image, with: "Fido url"
    fill_in :name, with: "Fido"
    fill_in :description, with: "A loveable cuddley pet"
    fill_in :approximate_age, with: 3
    fill_in :sex, with: "Male"
    click_button("Create Pet")
    expect(current_path).to eql("/shelters/#{shelter.id}/pets")
    expect(page).to have_content("Fido url")
    expect(page).to have_content("Fido")
    expect(page).to have_content("Male")
  end

  it "cannot create a pet with an incomplete form" do
    shelter = Shelter.create({name: "Happy Shelter",
                             address: "12980 Grover Drive",
                             city: "Doggy Vale",
                             state: "Colorado",
                             zip: 74578})


    visit "/shelters/#{shelter.id}/pets"
    click_link('Create Pet')
    expect(current_path).to eql("/shelters/#{shelter.id}/pets/new")

    fill_in :image, with: "Fido url"
    click_button("Create Pet")

    expect(current_path).to eql("/shelters/#{shelter.id}/pets/new")
    expect(page).to have_content("Please fill in all fields, including name, description, approximate age, sex")

    fill_in :image, with: "Fido url"
    fill_in :name, with: "Fido"
    click_button("Create Pet")
    expect(current_path).to eql("/shelters/#{shelter.id}/pets/new")
    expect(page).to have_content("Please fill in all fields, including description, approximate age, sex")

    fill_in :image, with: "Fido url"
    fill_in :name, with: "Fido"
    fill_in :description, with: "A loveable cuddley pet"
    click_button("Create Pet")
    expect(current_path).to eql("/shelters/#{shelter.id}/pets/new")
    expect(page).to have_content("Please fill in all fields, including approximate age, sex")

    fill_in :image, with: "Fido url"
    fill_in :name, with: "Fido"
    fill_in :description, with: "A loveable cuddley pet"
    fill_in :approximate_age, with: 3
    click_button("Create Pet")
    expect(current_path).to eql("/shelters/#{shelter.id}/pets/new")
    expect(page).to have_content("Please fill in all fields, including sex")

    fill_in :image, with: "Fido url"
    fill_in :name, with: "Fido"
    fill_in :description, with: "A loveable cuddley pet"
    fill_in :approximate_age, with: 3
    fill_in :sex, with: "Male"
    click_button("Create Pet")
    expect(current_path).to eql("/shelters/#{shelter.id}/pets")
  end
end
