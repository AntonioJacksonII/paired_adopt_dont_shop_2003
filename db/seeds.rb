# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
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
