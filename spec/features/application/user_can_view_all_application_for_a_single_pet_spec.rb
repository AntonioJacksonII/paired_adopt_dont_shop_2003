require "rails_helper"

RSpec.describe "Pet Applications Index Page", type: :feature do
  it "Can view all applications for a single pet" do

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

    application2 = Application.create({
        name: "Chris",
        address: "222 Chris Road",
        city: "Chris City",
        state: "Chris State",
        zip: "33233",
        phone: "3033897987",
        description: "Likes pets"
      })

      application3 = Application.create({
          name: "Jim",
          address: "222 Jim Road",
          city: "Jim City",
          state: "Jim State",
          zip: "23423",
          phone: "452343222",
          description: "Pet lover"
        })


    application1.pets << pet1
    application1.pets << pet2
    application2.pets << pet1
    application3.pets << pet2
    visit "/pets/#{pet1.id}"
    click_link("View All Applications")
    expect(current_path).to eql("/pets/#{pet1.id}/applications")
    within ".applicant-#{application1.id}" do
      expect(page).to have_content(application1.name)
    end
    within ".applicant-#{application2.id}" do
      expect(page).to have_content(application2.name)
    end
    expect(page).not_to have_css("applicant-#{application3.id}")
    expect(page).not_to have_content("#{application3.name}")
    click_link(application1.name)
    expect(current_path).to eql("/applications/#{application1.id}")
  end
end



# As a visitor
# When I visit a pets show page
# I see a link to view all applications for this pet
# When I click that link
# I can see a list of all the names of applicants for this pet
# Each applicant's name is a link to their application show page
