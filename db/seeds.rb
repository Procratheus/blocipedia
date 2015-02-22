require "faker"

User.delete_all
Wiki.delete_all

# Create Users
10.times do 
  user = User.new(
    name: Faker::Name.name,
    email: Faker::Internet.email,
    password: Faker::Lorem.characters(8...30)
    )
  user.save!
end

users = User.all

# Create Wiki
20.times do
  wiki = Wiki.new(
    user: users.sample,
    title: Faker::Lorem.sentence,
    description: Faker::Lorem.sentence,
    body: Faker::Lorem.paragraph
    )
  wiki.save!
end

wikis = Wiki.all

puts "Seeds finished"
puts "#{User.count} created"
puts "#{Wiki.count} created"



