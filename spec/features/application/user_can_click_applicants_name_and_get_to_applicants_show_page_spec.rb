require 'rails_helper'

RSpec.describe "Application Show Page", type: :feature do
  it "Can go to application show page when clicking applicants name" do

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
        description: "Love, pets have lots of space for them",
        status: "Approved"
      })

      visit "/pets"
      click_link("#{application1.name}")
      expect(current_path).to eql("/applications/#{application1.id}")



    application1.pets << pet1


  end
end
