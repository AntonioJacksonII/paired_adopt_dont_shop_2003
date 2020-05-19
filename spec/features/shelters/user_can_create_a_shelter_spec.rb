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

    expect(page).to have_content("Please fill in address, city, state, zip")
    fill_in :address, with: "123 Main St"
    click_on 'submit'
    expect(page).to have_content("Please fill in city, state, zip")
    fill_in :city, with: "Denver"
    click_on 'submit'
    expect(page).to have_content("Please fill in state, zip")
    fill_in :zip, with: "12345"
    click_on 'submit'
    expect(page).to have_content("Please fill in state")
    fill_in :state, with: "CO"
    click_on 'submit'
    expect(current_path).to eq("/shelters")
  end

end
