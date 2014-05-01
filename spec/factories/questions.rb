# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :question do
    association :user
    title {Faker::Lorem.sentence(4)}
    body {Faker::Lorem.paragraph}
  end
  factory :invalid_question, class: Question do
    association :user
    title nil
    body nil
  end
end
