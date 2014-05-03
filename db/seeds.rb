# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

require 'factory_girl'

User.all.each do |u|
  unless u.name == 'Shoroh'
    u.destroy!
  end
end

user1 = User.create!(name: 'microgenius', email: 'mail@microgenius.ru', password: 'supersecret', password_confirmation: 'supersecret')

user2 = User.create!(name: 'andrew', email: 'andrew@sikorsky.ru', password: 'supersecret', password_confirmation: 'supersecret')

user3 = User.create!(name: 'test', email: 'test@sikorsky.ru', password: 'supersecret', password_confirmation: 'supersecret')

10.times do
  FactoryGirl.create(:question, user: user1)
  FactoryGirl.create(:question, user: user2)
end

2.times do
  FactoryGirl.create(:deleted_question, user: user1)
  FactoryGirl.create(:deleted_question, user: user2)
end

2.times do
  FactoryGirl.create(:pending_question, user: user1)
  FactoryGirl.create(:pending_question, user: user2)
end
