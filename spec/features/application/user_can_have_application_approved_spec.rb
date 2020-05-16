require "rails_helper"

RSpec.describe "Application Show Page", type: :feature do
  it "Can approve applications" do
    shelter = Shelter.create({name: "Happy Shelter",
                          address: "12980 Grover Drive",
                          city: "Doggy Vale",
                          state: "Colorado",
                          zip: 74578})

    pet1 = shelter.pets.create(image: "cat.jpg", name: "Garfield", approximate_age: 1, sex: "Male", description: "Cute cat!")
    pet2 = shelter.pets.create(image: "cute.jpg", name: "Spot", approximate_age: 2, sex: "Male", description: "Spotted Puppy!")
    application1 = Application.create({
        name: "Bob",
        address: "222 Bob Road",
        city: "Bob City",
        state: "Bob State",
        zip: "39233",
        phone: "30332432",
        description: "Love, pets have lots of space for them"
      })

    application1.pets << pet1
    application1.pets << pet2
    visit "/applications/#{application1.id}"
    within ".pet-#{pet1.id}" do
    click_link("Approve Pet")
    end
    expect(current_path).to eql("/pets/#{pet1.id}")
    expect(page).to have_content("On hold for Bob")
    expect(page).to have_content("pending")
    expect(page).not_to have_content("adoptable")
  end
end



# As a visitor
# When I visit an application's show page
# For every pet that the application is for, I see a link
# to approve the application for that specific pet
# When I click on a link to approve the application for one particular pet
# I'm taken back to that pet's show page
# And I see that the pets status has changed to 'pending'
# And I see text on the page that says who this pet is on hold
# for (Ex: "On hold for John Smith",
