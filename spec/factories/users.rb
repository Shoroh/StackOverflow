# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    sequence(:name) { |n| "Bill#{n}" }
    sequence(:email) { |n| "BillHorwatzky#{n}@google.com" }
    password "12345678"
    password_confirmation "12345678"
    after(:create) do |user|
      create(:profile, user: user)
    end
  end
end
