# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :question do
    association :user
    title {Faker::Lorem.sentence(10)}
    body {Faker::Lorem.paragraph}
    status 0
    factory :deleted_question do
      status 2
    end
    factory :pending_question do
      status 1
    end
  end
  factory :invalid_question, class: Question do
    association :user
    title nil
    body nil
  end
end
