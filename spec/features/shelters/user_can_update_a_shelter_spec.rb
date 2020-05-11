require 'rails_helper'
  RSpec.describe "update shelter page" do
    it "can clink link and update page" do
      shelter = Shelter.create(name: "Savior's Shelter",
                                 address: "11111 Saviors St.",
                                 city: "Haven Central",
                                 state: "Colorado",
                                 zip: 90210)
      visit "/shelters/#{shelter.id}"

      click_link('Update Shelter')
      expect(current_path).to have_content("/shelters/#{shelter.id}/edit")
      fill_in 'name', with: "Doggy Paradise"
      fill_in 'address', with: "222 Kremlen Street"
      fill_in 'city', with: "Doggy Land"
      fill_in 'state', with: "Colorado"
      fill_in 'zip', with: 55555
      click_on 'submit'
      expect(current_path).to have_content("/shelters/#{shelter.id}")
      expect(page).to have_content("Doggy Paradise")
      expect(page).to have_content("222 Kremlen Street")
      expect(page).to have_content("Doggy Land")
      expect(page).to have_content("Colorado")
      expect(page).to have_content(55555)
    end
  end
