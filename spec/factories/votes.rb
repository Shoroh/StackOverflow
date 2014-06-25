# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :vote do
    association :votable, factory: :answer
    user 1
    value 1
  end
end
