require 'rails_helper'

RSpec.describe "Shelter Show Page", type: :feature do
  it "Can display reviews from shelters show page" do

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
    expect(page).to have_content(review_1.title)
    expect(page).to have_content(review_1.rating)
    expect(page).to have_content(review_1.content)
    expect(page).to have_content(review_2.title)
    expect(page).to have_content(review_2.rating)
    expect(page).to have_content(review_2.content)
    expect(page).to have_content(review_2.picture)
  end
end



# As a visitor,
# When I visit a shelter's show page,
# I see a list of reviews for that shelter
# Each review will have:
# - title
# - rating
# - content
# - an optional picture
