require 'rails_helper'

describe 'Navigation Bar', type: :feature do
  it "links to the favorites index when user clicks favorite indicator" do
    visit '/shelters'
    click_link 'Favorite Pets: 0'

    expect(current_path).to eq('/favorites')
  end
end
