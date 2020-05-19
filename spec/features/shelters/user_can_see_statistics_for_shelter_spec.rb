require "rails_helper"

RSpec.describe "Shelter Show Page", type: :feature do
  it "Can display statistics for shelter" do
    shelter = Shelter.create(name: "Kitty Shelter",
                             address: "12888 Kitty Drive",
                             city: "Kitty Vale",
                             state: "Kitty Twon",
                             zip: 73429)

   pet1 = shelter.pets.create(image: "cat.jpg", name: "Garfield", approximate_age: 1, sex: "Male", description: "Cute cat!")
   pet2 = shelter.pets.create(image: "cute.jpg", name: "Spot", approximate_age: 2, sex: "Male", description: "Spotted Puppy!")
   pet3 = shelter.pets.create(image: "kitten.jpg", name: "Kitty", approximate_age: 2, sex: "Female", description: "Adorable kitten")

   review_1 = Review.create(title: "Great Shelter",
     rating: 5,
     content: "Awesome experience",
     shelter_id: shelter.id)

   review_2 = Review.create(title: "Worst Shelter",
     rating: 1,
     content: "Inhumaine Experience",
     picture: "Shelter Url",
     shelter_id: shelter.id)

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
   application1.pets << pet3
   application2.pets << pet1
   application3.pets << pet1

   visit "/shelters/#{shelter.id}"
   expect(page).to have_content("Count of Pets: 3")
   expect(page).to have_content("Average Shelter Review Rating: 3.0")
   expect(page).to have_content("Number of applications on file: 3")
  end
end
