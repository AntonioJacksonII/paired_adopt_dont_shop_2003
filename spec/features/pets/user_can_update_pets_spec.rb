require 'rails_helper'

RSpec.describe "Pet's Show Page Update", type: :feature do
  it "Can update pets" do

    shelter_1 = Shelter.create({name: "Happy Shelter",
                             address: "12980 Grover Drive",
                             city: "Doggy Vale",
                             state: "Colorado",
                             zip: 74578})

    pet = Pet.create({
      image: "Bella Url",
      name: "Bella",
      approximate_age: 3,
      sex: "Female",
      shelter_id: shelter_1.id

      })
    visit "/pets/#{pet.id}"
    click_link('Update Pet')
    expect(current_path).to eql("/pets/#{pet.id}/edit")
    fill_in :image, with: "Fang Url"
    fill_in :name, with: "Fang"
    fill_in :description, with: "A loyal Pet"
    fill_in :approximate_age, with: 4
    fill_in :sex, with: "Male"
    click_on 'Update Pet'
    expect(current_path).to eql("/pets/#{pet.id}")
    expect(page).to have_content("Fang Url")
    expect(page).to have_content("Fang")
    expect(page).to have_content("A loyal Pet")
    expect(page).to have_content("Male")
    expect(page).to have_content("adoptable")
    expect(page).to have_content(4)
    expect(page).not_to have_content("Bella")
    expect(page).not_to have_content("Bella Url")
    expect(page).not_to have_content(3)
    expect(page).not_to have_content("Female")

  end
end
