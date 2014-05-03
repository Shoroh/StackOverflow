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

FactoryGirl.create_list(:question, 50)
FactoryGirl.create_list(:pending_question, 20)
FactoryGirl.create_list(:deleted_question, 20)
