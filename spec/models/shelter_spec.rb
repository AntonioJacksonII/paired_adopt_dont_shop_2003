require 'rails_helper'
describe Shelter, type: :model do
  describe "validations" do
    it { should validate_presence_of :name }
    it { should validate_presence_of :address }
    it { should validate_presence_of :city }
    it { should validate_presence_of :state }
    it { should validate_presence_of :zip }
  end
  describe 'relationships' do
    it { should have_many :pets }
    it { should have_many :reviews}
  end

  describe 'instance methods' do
    it "count_of_pets" do
    shelter = Shelter.create(name: "Kitty Shelter",
                             address: "12888 Kitty Drive",
                             city: "Kitty Vale",
                             state: "Kitty Twon",
                             zip: 73429)

    expect(shelter.count_of_pets).to eql(0)
     pet_1 = Pet.create({
       image: "pet_url_1",
       name: "Sparky",
       approximate_age: 5,
       sex: "Male",
       shelter_id: shelter.id

       })

     pet_2 = Pet.create({
       image: "pet_url_2",
       name: "Silly",
       approximate_age: 2,
       sex: "Female",
       shelter_id: shelter.id
       })
    expect(shelter.count_of_pets).to eql(2)
  end

  it "average_rating" do

    shelter_2 = Shelter.create(name: "Doggy Shelter",
                             address: "12888 Doggy Drive",
                             city: "Doggy Vale",
                             state: "Doggy Town",
                             zip: 73429)

    review_4 = Review.create(title: "Ok Shelter",
      rating: 2,
      content: "Not Bad",
      picture: "Shelter Url",
      shelter_id: shelter_2.id)

    shelter = Shelter.create(name: "Kitty Shelter",
                             address: "12888 Kitty Drive",
                             city: "Kitty Vale",
                             state: "Kitty Twon",
                             zip: 73429)

   review_1 = Review.create(title: "Great Shelter",
     rating: 5,
     content: "Awesome experience",
     shelter_id: shelter.id)

   review_2 = Review.create(title: "Worst Shelter",
     rating: 1,
     content: "Inhumaine Experience",
     picture: "Shelter Url",
     shelter_id: shelter.id)

  expect(shelter.average_rating).to eql(3.0)

  review_3 = Review.create(title: "Great Shelter",
    rating: 4,
    content: "Not a bad place, staff a little cranky",
    picture: "Shelter Url",
    shelter_id: shelter.id)

    expect(shelter.average_rating).to eql(3.3)
  end

  it "number_of_applications" do
    shelter = Shelter.create(name: "Kitty Shelter",
                             address: "12888 Kitty Drive",
                             city: "Kitty Vale",
                             state: "Kitty Twon",
                             zip: 73429)

   pet1 = shelter.pets.create(image: "cat.jpg", name: "Garfield", approximate_age: 1, sex: "Male", description: "Cute cat!")
   pet2 = shelter.pets.create(image: "cute.jpg", name: "Spot", approximate_age: 2, sex: "Male", description: "Spotted Puppy!")
   pet3 = shelter.pets.create(image: "kitten.jpg", name: "Kitty", approximate_age: 2, sex: "Female", description: "Adorable kitten")

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
   expect(shelter.number_of_applications).to eql(3)
  end
end


end
