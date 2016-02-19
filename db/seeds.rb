# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

names = %w[husband wife son daughter cute\ doggy]
%w[sheperd clink simpson underhill].each do |n|
  Household.create(name: n).tap do |household|
    4.times do
      person = household.people.create(name: names.sample)
      (7.days.ago.to_date..Date.today).each do |day|
        person.bowls.create(chips: rand(30), created_at: day)
      end
    end
  end
end
