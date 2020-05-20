require "rails_helper"

RSpec.describe "Shelter Show Page", type: :feature do
  it "Will delete all reviews for shelter upon deleting it" do
    shelter = Shelter.create(name: "Kitty Shelter",
                             address: "12888 Kitty Drive",
                             city: "Kitty Vale",
                             state: "Kitty Twon",
                             zip: 73429)
    review1 = Review.create(title: "Terrible Place",
                             rating: 1,
                             content: "The animals sleep in cages",
                             shelter_id: shelter.id)

   review2 = Review.create(title: "Not Bad",
                            rating: 3,
                            content: "Great customer service",
                            shelter_id: shelter.id)


    visit "/reviews"
    within ("#review-#{review1.id}") do
      expect(page).to have_content(review1.title)
      expect(page).to have_content(review1.rating)
      expect(page).to have_content(review1.content)
    end
    within ("#review-#{review2.id}") do
      expect(page).to have_content(review2.title)
      expect(page).to have_content(review2.rating)
      expect(page).to have_content(review2.content)
    end
    visit "shelters/#{shelter.id}"
    click_link("Delete Shelter")
    visit "/reviews"
    expect(page).not_to have_css("review-#{review1.id}")
    expect(page).not_to have_content(review1.title)
    expect(page).not_to have_css("review-#{review2.id}")
    expect(page).not_to have_content(review2.title)



  end
end







# As a visitor
# When I delete a shelter
# All reviews associated with that shelter are also deleted
