require 'rails_helper'

RSpec.describe "shelter index page", type: :feature do
  it "can see all shelter names" do
    shelter_1 = Shelter.create(name: "Savior's Shelter",
                               address: "11111 Saviors St.",
                               city: "Haven Central",
                               state: "Colorado",
                               zip: 90210)

   shelter_2 = Shelter.create(name: "Smiley's Shelter",
                              address: "2222 Joker St.",
                              city: "Smiley Central",
                              state: "Colorado",
                              zip: 12180)

   visit "/shelters"

   expect(page).to have_content(shelter_1.name)
   expect(page).to have_content(shelter_2.name)
  end


end
