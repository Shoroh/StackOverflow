# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :karma do
    user nil
    karmable ""
    score 1
    action "MyString"
  end
end
