require 'rails_helper'

RSpec.describe "Delete Pet Page", type: :feature do
  it "Can Delete A Pet From Pet Show Page" do

    shelter_1 = Shelter.create({name: "Happy Shelter",
                             address: "12980 Grover Drive",
                             city: "Doggy Vale",
                             state: "Colorado",
                             zip: 74578})

    pet = Pet.create({
      image: "Happy Url",
      name: "Raulgh",
      approximate_age: 2,
      sex: "Male",
      shelter_id: shelter_1.id
      })

    visit "/pets/#{pet.id}"
    expect(page).to have_content(pet.image)
    expect(page).to have_content(pet.name)
    expect(page).to have_content(pet.approximate_age)
    expect(page).to have_content(pet.sex)
    click_link("Delete Pet")
    expect(current_path).to eql("/pets")
    expect(page).to_not have_content(pet.image)
    expect(page).to_not have_content(pet.name)
  


  end

end
