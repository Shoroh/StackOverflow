# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    username              "Shoroh"
    email                 "shoroh362@gmail.com"
    password              "12345678"
    pasword_confirmation  "12345678"

  end
end
