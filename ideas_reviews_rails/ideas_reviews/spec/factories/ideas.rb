FactoryBot.define do
  factory :idea do
    association(:user, factory: :user) # user
    title { Faker::Job.title } 
    description { Faker::Hacker.say_something_smart }
  end
end
