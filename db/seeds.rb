# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

10.times do |n|
  name  = Faker::RockBand.unique.name
  description = Faker::Lorem.paragraph(4)
  Artist.create!(name:  name,
               description: description)
end

5.times do
  Artist.all.each do |artist|
    name = Faker::Music.album
    description = Faker::Lorem.unique.sentence(5)
    artist.lps.create!(name: name, description: description)
  end
end
