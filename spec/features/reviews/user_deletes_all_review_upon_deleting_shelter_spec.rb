require "rails_helper"

RSpec.describe "Shelter Show Page", type: :feature do
  it "Will delete all reviews for shelter upon deleting it" do
    shelter = Shelter.create(name: "Kitty Shelter",
                             address: "12888 Kitty Drive",
                             city: "Kitty Vale",
                             state: "Kitty Twon",
                             zip: 73429)
    review = Review.create(title: "Terrible Place",
                             rating: 1,
                             content: "The animals sleep in cages",
                             shelter_id: shelter.id)


    visit "/reviews"
    expect(page).to have_content(review.title)
    expect(page).to have_content(review.rating)
    expect(page).to have_content(review.content)                         
    visit "shelters/#{shelter.id}"
    click_link("Delete Shelter")
    visit "/reviews"
    expect_page.not_to have_css("review-#{review.id}")
    expect_page.not_to have_content(review.title)


  end
end







# As a visitor
# When I delete a shelter
# All reviews associated with that shelter are also deleted
