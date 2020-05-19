require 'rails_helper'

RSpec.describe "shelter create page", type: :feature do
  it "can create shelters" do
    visit "/shelters"
    click_link('New Shelter')
    expect(current_path).to have_content('/shelters/new')
    fill_in :name, with: "Dog Shelter"
    fill_in :address, with: "12980 Grover Drive"
    fill_in :city, with: "Doggy Vale"
    fill_in :state, with: "Colorado"
    fill_in :zip, with: 74578
    click_on 'submit'
    expect(current_path).to have_content('/shelters')
    expect(page).to have_content("Dog Shelter")
  end

  it "displays a flash message indicating missing fields on incomplete forms" do
    visit "/shelters"
    click_link('New Shelter')
    fill_in :name, with: "Dog Shelter"

    click_on 'submit'

    expect(page).to have_content("Please fill in the address, city, state, and zip")
  end

end
