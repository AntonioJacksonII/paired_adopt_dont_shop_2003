require "rails_helper"

  RSpec.describe "Shelter Show Page", type: :feature do
    it "can edit shelter review from shelter show page" do

      shelter = Shelter.create(name: "Kitty Shelter",
                               address: "12888 Kitty Drive",
                               city: "Kitty Vale",
                               state: "Kitty Twon",
                               zip: 73429)
      review = Review.create(title: "Terrible Place",
                               rating: 1,
                               content: "The animals sleep in cages",
                               shelter_id: shelter.id)

    visit "/shelters/#{shelter.id}"
    click_link("Edit Review")
    expect(current_path).to eql("/shelters/#{shelter.id}/reviews/#{review.id}/edit")

    fill_in :title, with: "Great Shelter"
    fill_in :rating, with: 5
    fill_in :content, with: "Great experience friendly staff"

    click_on('Edit Review')
    expect(current_path).to eql("/shelters/#{shelter.id}")
    expect(page).to have_content("Great Shelter")
    expect(page).to have_content(5)
    expect(page).to have_content("Great experience friendly staff")
    end

    it "display an error message and goes to edit review page if review not complete" do
      shelter = Shelter.create(name: "Kitty Shelter",
                               address: "12888 Kitty Drive",
                               city: "Kitty Vale",
                               state: "Kitty Twon",
                               zip: 73429)
      review = Review.create(title: "Terrible Place",
                               rating: 1,
                               content: "The animals sleep in cages",
                               shelter_id: shelter.id)

     visit "shelters/#{shelter.id}"
     click_link('Edit Review')
     expect(current_path).to eql("/shelters/#{shelter.id}/reviews/#{review.id}/edit")
     fill_in :title, with: "Horrible"
     click_on 'Edit Review'
     expect(current_path).to eql("/shelters/#{shelter.id}/reviews/#{review.id}/edit")
     expect(page).to have_content("Please Fill In Title, Rating, and Content")

   end
   it "Will display error message if review rating is not between 1 and 5" do
     shelter = Shelter.create(name: "Kitty Shelter",
                              address: "12888 Kitty Drive",
                              city: "Kitty Vale",
                              state: "Kitty Twon",
                              zip: 73429)
     review = Review.create(title: "Terrible Place",
                              rating: 1,
                              content: "The animals sleep in cages",
                              shelter_id: shelter.id)

      visit "shelters/#{shelter.id}"
      click_link('Edit Review')
      expect(current_path).to eql("/shelters/#{shelter.id}/reviews/#{review.id}/edit")
      fill_in :title, with: "Horrible"
      fill_in :rating, with: 100
      click_on 'Edit Review'

      expect(current_path).to eql("/shelters/#{shelter.id}/reviews/#{review.id}/edit")
      expect(page).to have_content("Please select a rating between 1 and 5")
   end

end


#   As a visitor,
# When I visit a shelter's show page
# I see a link to edit the shelter review next to each review.
# When I click on this link, I am taken to an edit shelter review path
# On this new page, I see a form that includes that review's pre populated data:
# - title
# - rating
# - content
# - image
# I can update any of these fields and submit the form.
# When the form is submitted, I should return to that shelter's show page
# And I can see my updated review
