require 'rails_helper'

RSpec.describe "Shelter Index Page", type: :feature do
  it "Can edit shelters from the shelter index page" do
    shelter = Shelter.create(name: "Peanut Shelter",
                             address: "91999 Peanut Drive",
                             city: "Peanut Vale",
                             state: "Peanut Twon",
                             zip: 68940)

    visit "/shelters"
    click_link("Delete Shelter")

    expect(current_path).to eql("/shelters")
    expect(page).not_to have_content("Peanut Shelter")
    expect(page).not_to have_content("91999 Peanut Drive")
    expect(page).not_to have_content("Peanut Vale")
    expect(page).not_to have_content("Peanut Twon")
    expect(page).not_to have_content(68940)


  end
end
