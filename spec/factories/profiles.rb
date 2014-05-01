# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :profile do
    age 34
    facebook_id '23232asdsad'
    display_name {Faker::Name.name}
    user
  end
end
