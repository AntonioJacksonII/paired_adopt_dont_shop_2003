require "rails_helper"

RSpec.describe "Shelter Show Page", type: :feature do
  it "Can not delete shelter if it has any approved applications for any pets" do
    shelter = Shelter.create({name: "Happy Shelter",
                             address: "12980 Grover Drive",
                             city: "Doggy Vale",
                             state: "Colorado",
                             zip: 74578})

    pet = Pet.create({
      image: "Happy Url",
      name: "Raulgh",
      approximate_age: 27,
      sex: "Male",
      shelter_id: shelter.id
      })

      visit "/pets/#{pet.id}"
      click_button("Favorite This Pet")
      visit "/applications/new"
      check "#{pet.id}"

      fill_in :name, with: "Applicant A"
      fill_in :address, with: "123 A St"
      fill_in :city, with: "Fake"
      fill_in :state, with: "CO"
      fill_in :zip, with: "80202"
      fill_in :phone, with: "123-456-7891"
      fill_in :description, with: "Clean home"
      click_button("Submit Application")
      visit "/pets/#{pet.id}/applications"
      expect(page).to have_content("#{pet.name}")
      expect(page).to have_con

  end
end
