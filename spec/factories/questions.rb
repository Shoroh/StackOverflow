# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :question do
    title "How to patch KDE under FreeBSD?"
    body "It is very interesting!"
    user_id 1
  end
  factory :invalid_question, class: Question do
    title nil
    body nil
    user_id nil
  end
end
