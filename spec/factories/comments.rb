# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :comment do
    user nil
    association :commentable
    body "Just comment"
    factory :invalid_comment do
      body '1'
    end
  end
end
