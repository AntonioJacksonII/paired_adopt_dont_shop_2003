require 'rails_helper'

describe "Shelter Show Page", type: :feature do
  it "Can delete reviews from shelters show page" do

    shelter = Shelter.create(name: "Kitty Shelter",
                             address: "12888 Kitty Drive",
                             city: "Kitty Vale",
                             state: "Kitty Twon",
                             zip: 73429)
     review_1 = Review.create(title: "Great Shelter",
       rating: 5,
       content: "Awesome experience",
       shelter_id: shelter.id)

     review_2 = Review.create(title: "Worst Shelter",
       rating: 1,
       content: "Inhumaine Experience",
       picture: "Shelter Url",
       shelter_id: shelter.id)

     visit "shelters/#{shelter.id}"
     click_link("Delete Review #{review_1.id}")
     expect(current_path).to eq("/shelters/#{shelter.id}")

     expect(page).to_not have_content("Great Shelter")
     expect(page).to_not have_content(5)
     expect(page).to_not have_content("Great experience friendly staff")

     expect(page).to have_content("Worst Shelter")
     expect(page).to have_content(1)
     expect(page).to have_content("Inhumaine Experience")
  end
end


# User Story 7, Delete a Shelter Review
#
# As a visitor,
# When I visit a shelter's show page,
# I see a link next to each shelter review to delete the review.
# When I delete a shelter review I am returned to the shelter's show page
# # And I should no longer see that shelter review
