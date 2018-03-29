# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'open-uri'
require 'json'

url_ingredient = "https://www.thecocktaildb.com/api/json/v1/1/list.php?i=list"
list_ingredient = open(url_ingredient).read
ingredients = JSON.parse(list_ingredient)

ingredients_max = ingredients["drinks"].sample(50)
ingredients_max.each do |ingredient|
  Ingredient.create(name: ingredient["strIngredient1"])
end
puts "---------"
puts "Done! Loaded #{ingredients_max.count} ingredients in the DB"
puts "---------"


url_cocktail = "https://www.thecocktaildb.com/api/json/v1/1/filter.php?a=Alcoholic"
list_cocktail = open(url_cocktail).read
cocktails = JSON.parse(list_cocktail)

drinks = cocktails["drinks"].sample(50)
drinks.each do |cocktail|
  Cocktail.create(name: cocktail["strDrink"])
end
puts "---------"
puts "Done! Loaded #{drinks.count} cocktails in the DB"
puts "---------"


url_dose = "https://raw.githubusercontent.com/teijo/iba-cocktails/master/recipes.json"
list_dose = open(url_dose).read
doses = JSON.parse(list_dose)
doses_max = doses.sample(10)

doses_max.each do |recipe|
  ingredients = recipe["ingredients"].first
  amount = ingredients["amount"]
  unit = ingredients["unit"]
  Dose.create(description: "#{amount} + #{unit}")
end
puts "---------"
puts "Done! Loaded #{doses_max.count} doses in the DB"
puts "---------"

# Ingredient.create(name: "lemon")
# Ingredient.create(name: "ice")
# Ingredient.create(name: "mint leaves")
