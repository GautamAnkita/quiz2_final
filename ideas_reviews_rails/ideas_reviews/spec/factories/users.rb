FactoryBot.define do
  factory :user do
    name { Faker::Name.first_name }
    sequence(:email) { |n| Faker::Internet.email.sub("@", "-#{n}@") }# sub for one replacement and gsub for multiple replacements.
    password "supersecret"
  end
end
