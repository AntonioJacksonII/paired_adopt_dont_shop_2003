require 'rails_helper'

RSpec.describe "find shelter page" do
  it "can find shelter with id" do
    shelter_1 = Shelter.create(name: "Savior's Shelter",
                               address: "11111 Saviors St.",
                               city: "Haven Central",
                               state: "Colorado",
                               zip: 90210)

  visit "/shelters/#{shelter_1.id}"

  expect(page).to have_content(shelter_1.name)
  expect(page).to have_content(shelter_1.address)
  expect(page).to have_content(shelter_1.city)
  expect(page).to have_content(shelter_1.state)
  expect(page).to have_content(shelter_1.zip)
  end

end
