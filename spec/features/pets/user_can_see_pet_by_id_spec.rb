require 'rails_helper'

RSpec.describe "Pet Show Page", type: :feature do
  it "Can Show Pet" do

    shelter_2 = Shelter.create({name: "Doggy Haven",
                             address: "22222 Haven Street",
                             city: "Doggy Vale",
                             state: "California",
                             zip: 86192})

     pet_1 = Pet.create({
       image: "pet_url_1",
       name: "Sparky",
       approximate_age: 5,
       sex: "Male",
       shelter_id: shelter_2.id,
       description: "Cute Puppy with black and white fur",
       adoption_status: "Adoptable"
       })



       visit "/pets/#{pet_1.id}"

       expect(page).to have_content(pet_1.image)
       expect(page).to have_content(pet_1.name)
       expect(page).to have_content(pet_1.description)
       expect(page).to have_content(pet_1.approximate_age)
       expect(page).to have_content(pet_1.sex)
       expect(page).to have_content(pet_1.description)
       expect(page).to have_content(pet_1.adoption_status)
     end
end



# As a visitor
# When I visit '/pets/:id'
# Then I see the pet with that id including the pet's:
# - image
# - name
# - description
# - approximate age
# - sex
# - adoptable/pending adoption status
