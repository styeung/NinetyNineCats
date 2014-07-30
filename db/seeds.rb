# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

cats = Cat.create!([
  {age: 2, birth_date: "January 6, 1950", color: "black", sex:"M", name:"Grandpa", description:"He's old"},
  {age: 87, birth_date: "January 6, 1954", color: "black", sex:"M", name:"Man", description:"old"},
  {age: 42, birth_date: "March 6, 1989", color: "white", sex:"F", name:"Scarlett", description:"Johansson"},
  {age: 22, birth_date: "February 10, 2000", color: "brown", sex:"F", name:"Sai To", description:"cat"},
  {age: 23, birth_date: "September 6, 1850", color: "pink", sex:"F", name:"her", description:"cat"}
])