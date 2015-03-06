require "faker"

User.delete_all
Wiki.delete_all
Collaborator.delete_all

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
    role: "premium"
    )
  user.save!
end

public_users = User.where(role: "public")
premium_users = User.where(role: "premium")

admin = User.new(
  name: "administrator  ",
  email: "admin@example.com",
  password: "helloworld",
  role: "admin"
  )
admin.skip_confirmation!
admin.save!

# Create Wiki
10.times do
  wiki = Wiki.new(
    user_id: premium_users.sample.id,
    title: Faker::Lorem.word,
    description: Faker::Lorem.sentence,
    body: Faker::Lorem.paragraph,
    private: true
    )
  wiki.save!
end

10.times do
  wiki = Wiki.new(
    user_id: public_users.sample.id,
    title: Faker::Lorem.word,
    description: Faker::Lorem.sentence,
    body: Faker::Lorem.paragraph,
    private: false
    )
  wiki.save!
end

wikis = Wiki.all

# Create Collaborators

premium_users.each do |user|
  collaborator = Collaborator.new(
    user_id: user.id,
    wiki_id: wikis.where(private: true, user_id: user.id).sample.id
    )
  collaborator.save!
end

collaborators = Collaborator.all

puts "Seeds finished"
puts "#{User.where(role: "admin").count} admin users created"
puts "#{User.where(role: "public").count} public users created"
puts "#{User.where(role: "premium").count} premium users created"
puts "#{Wiki.where(private: true).count} private wikis created"
puts "#{Wiki.where(private: false).count} public wikis created"
puts "#{Collaborator.count} collaborators created"

