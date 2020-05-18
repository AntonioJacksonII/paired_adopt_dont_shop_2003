# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
ApplicationPet.destroy_all
Application.destroy_all
Pet.destroy_all
Shelter.destroy_all
Review.destroy_all


shelter_1 = Shelter.create(name: "Savior's Shelter",
                           address: "11111 Saviors St.",
                           city: "Haven Central",
                           state: "Colorado",
                           zip: 90210)



shelter_2 = Shelter.create(name: "Smiley's Shelter",
                           address: "2222 Joker St.",
                           city: "Smiley Central",
                           state: "Colorado",
                           zip: 12180)

pet_1 = Pet.create(image: "Curly Url",
                    name: "Curly",
                    approximate_age: 4,
                    sex: "Male",
                    shelter_id: shelter_1.id,
                    description: "A Curly Pet",
                    adoption_status: "adoptable")
pet2 = shelter_2.pets.create(image: "cute.jpg", name: "Spot", approximate_age: 2, sex: "Male", description: "Spotted Puppy!")
pet3 = shelter_2.pets.create(image: "cat.jpg", name: "Garfield", approximate_age: 1, sex: "Male", description: "Cute cat!")


review_1 = Review.create(title: "Terrible Place",
                         rating: 1,
                         content: "The animals sleep in cages",
                         shelter_id: shelter_1.id)
review_2 = Review.create(title: "Wonderful Place",
                         rating: 5,
                         content: "The animals sleep in piles of diamonds!",
                        shelter_id: shelter_2.id)
