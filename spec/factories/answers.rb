# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :answer do
    user nil
    question nil
    body "MyText"
    factory :invalid_answer do
      body '2f'
    end
  end
end
