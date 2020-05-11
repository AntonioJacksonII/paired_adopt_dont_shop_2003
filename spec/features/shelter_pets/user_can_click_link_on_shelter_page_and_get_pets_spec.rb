require 'rails_helper'

RSpec.describe "Shelters Index Page", type: :feature do
 it "can go to shelter pets page from shelter page" do

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

  visit "shelters/#{shelter.id}"
  click_link("View Shelters Pets")
  expect(current_path).to eql("/shelters/#{shelter.id}/pets")
  end
end
