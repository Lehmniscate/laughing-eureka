# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
User.destroy_all
Cat.destroy_all


user = User.new(user_name: "admin")
user2 = User.new(user_name: "Das")

user.password = "password"
user2.password = "gutentag"

user.save!
user2.save!

Cat.create!(name: "Garfield", birth_date: "01/01/2001", color: "orange", sex: "M", user_id: user.id)
Cat.create!(name: "Vader", birth_date: "01/01/1900", color: "black", sex: "M", user_id: user2.id)
