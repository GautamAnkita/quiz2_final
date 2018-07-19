# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
PASSWORD = "supersecret"
Review.delete_all
Idea.delete_all
User.delete_all

super_user = User.create(
  name: "JonSnow",
  email: "js@winterfell.gov",
  password: PASSWORD,
  admin: true
)

50.times do
  first_name = Faker::Name.first_name
  
  User.create(
    name: first_name,
    email: "#{first_name.downcase}.#{first_name.downcase}@example.com",
    password: PASSWORD
  )
end

users = User.all


100.times do
    i = Idea.create(
      title: Faker::Job.title,
      description: Faker::Coffee.notes,
      user: User.all.sample
    )
    if i.valid?
      rand(0..10).times do
        Review.create(
          description: Faker::Matz.quote,
          idea: i,
          user: User.all.sample
        )
      end
    end
end
  
  ideas = Idea.all
  reviews = Review.all
  
  puts Cowsay.say "Created #{users.count} users", :tux
  puts Cowsay.say("Created #{ideas.count} ideas", :cow)
  puts Cowsay.say("Created #{reviews.count} reviews", :sheep)
  puts "Login with #{super_user.email} and password of '#{PASSWORD}'"