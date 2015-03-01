require "faker"

User.delete_all
Wiki.delete_all

# Create Users
5.times do 
  user = User.new(
    name: Faker::Name.name,
    email: Faker::Internet.email,
    password: Faker::Lorem.characters(8...30),
    role: "public"
    )
  user.save!
end

5.times do 
  user = User.new(
    name: Faker::Name.name,
    email: Faker::Internet.email,
    password: Faker::Lorem.characters(8...30),
    role: "private"
    )
  user.save!
end

users = User.all

# Create Wiki
10.times do
  wiki = Wiki.new(
    user: users.sample,
    title: Faker::Lorem.sentence,
    description: Faker::Lorem.sentence,
    body: Faker::Lorem.paragraph,
    private: nil
    )
  wiki.save!
end

10.times do
  wiki = Wiki.new(
    user: users.sample,
    title: Faker::Lorem.sentence,
    description: Faker::Lorem.sentence,
    body: Faker::Lorem.paragraph,
    private: true
    )
  wiki.save!
end

wikis = Wiki.all

puts "Seeds finished"
puts "#{User.count} users created"
puts "#{Wiki.count} wikis created"



