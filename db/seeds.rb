
# Artists
10.times do
  Artist.create!(name:  Faker::RockBand.unique.name,
                 description: Faker::Lorem.paragraph(10))
end

# LPs
5.times do
  Artist.all.each do |artist|
    name = Faker::Music.album
    description = ""
    5.times { |n| description += "#{n+1}. #{Faker::Lorem.unique.sentence(5)}\n" }
    artist.lps.create!(name: name, description: description)
  end
end
