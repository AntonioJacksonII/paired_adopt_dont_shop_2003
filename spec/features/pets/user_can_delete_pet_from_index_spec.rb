require 'rails_helper'

RSpec.describe "Shelter Index Page", type: :feature do
  it "can delete pet from index page" do

    shelter_1 = Shelter.create({name: "Mildias Shelter",
                             address: "12980 Grover Drive",
                             city: "Doggy Vale",
                             state: "Colorado",
                             zip: 74578})

    pet = Pet.create({
      image: "Cloudy Url",
      name: "Cloudy",
      approximate_age: 41,
      sex: "Female",
      shelter_id: shelter_1.id
      })

   visit '/pets'
   click_link("Delete Pet #{pet.id}")
   expect(current_path).to eql('/pets')
   expect(page).not_to have_content(pet.image)
   expect(page).not_to have_content(pet.name)
   expect(page).not_to have_content(pet.approximate_age)
 end

 it "cannot delete pet with an approved application from index page" do
    shelter_1 = Shelter.create({name: "Mildias Shelter",
                            address: "12980 Grover Drive",
                            city: "Doggy Vale",
                            state: "Colorado",
                            zip: 74578})
    pet = Pet.create({
       image: "Cloudy Url",
       name: "Cloudy",
       approximate_age: 41,
       sex: "Female",
       shelter_id: shelter_1.id,
       })
    application1 = Application.create({
           name: "Bob",
           address: "222 Bob Road",
           city: "Bob City",
           state: "Bob State",
           zip: "39233",
           phone: "30332432",
           description: "Love, pets have lots of space for them"
         })
      application1.pets << pet
      visit "/applications/#{application1.id}"
      click_link("Approve Pet")
      visit '/pets'
      expect(page).to_not have_link("Delete Pet")
  end
end
