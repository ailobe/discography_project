
# Artists
10.times do
  name = ''
  while name.empty?
    faker = Faker::RockBand.unique.name
    if faker.length > 50
      next
    else
      name = faker
      break
    end
  end
  description = ''
  while description.empty?
    faker = Faker::Lorem.paragraph(11)
    faker.length > 255 ? next : description = faker
  end
  Artist.create!(name:  name,
                 description: description)
end

# LPs
5.times do
  Artist.all.each do |artist|
    name = Faker::Music.album
    description = "1. #{Faker::Lorem.unique.sentence(5)}"
    description += "\n2. #{Faker::Lorem.unique.sentence(5)}"
    description += "\n3. #{Faker::Lorem.unique.sentence(5)}"
    description += "\n4. #{Faker::Lorem.unique.sentence(5)}"
    description += "\n5. #{Faker::Lorem.unique.sentence(5)}"
    artist.lps.create!(name: name, description: description)
  end
end
