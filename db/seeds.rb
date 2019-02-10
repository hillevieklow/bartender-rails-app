# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


ingredients = Ingredient.create([{name: 'Vodka'}, {name: 'Redbull'}, {name: 'Gin'}, {name: 'Tonic'}, {name: 'Bloody Mary Mix'}])

users = User.create([
  {email: 'hello@my.com', name: 'Hanna', password: 'Test'},
  {email: 'coco@my.com', name: 'Geoffery', password: 'Test'},
  {email: 'nice@my.com', name: 'Gustaaf', password: 'Test'}])

recipes = Recipe.create([{name: 'Vodka Redbull', description: 'When Red Bull, a heavily caffeinated energy drink is mixed with alcohol like vodka, a potent drink is prepared which can make you feel elevated even though you are drunk and intoxicated.', directions: '1) Take highball glass fill it up with ice cubes. 2) Pour vodka over ice. 3) Top it with Red bull until full and serve.', user_id: users[0].id, upvotes: 10},
  {name: 'Gin & Tonic', description: 'Classic and easy, the gin and tonic is light and refreshing. It\'s a simple mixed drink—requiring just the two ingredients—and is perfect for happy hour, dinner, or anytime you simply want an invigorating beverage.', directions: '1) In a highball glass filled with ice cubes, pour the gin then top it with tonic. 2) Stir well.', user_id: users[1].id, upvotes: 5},
  {name: 'Bloody Mary', description: 'A Bloody Mary is a cocktail containing vodka, tomato juice, and combinations of other spices and flavorings including Worcestershire sauce, hot sauces, garlic, herbs, horseradish, celery, olives, salt, black pepper, lemon juice, lime juice and/or celery salt.', directions: '1) Add all the ingredients into a mixing glass and stir. 2) Pour into a chilled highball glass over ice.', user_id: users[2].id, upvotes: 11}])

recipe_ingredients = RecipeIngredient.create([{name: ingredients[0].name, ingredient_id: ingredients[0].id, recipe_id: recipes[0].id, quantity: "2 ounces"},
  {name: ingredients[1].name, ingredient_id: ingredients[1].id, recipe_id: recipes[0].id, quantity: "5 ounces"},
  {name: ingredients[2].name, ingredient_id: ingredients[2].id, recipe_id: recipes[1].id, quantity: "2 ounces"},
  {name: ingredients[3].name, ingredient_id: ingredients[3].id, recipe_id: recipes[1].id, quantity: "5 ounces"},
  {name: ingredients[0].name, ingredient_id: ingredients[0].id, recipe_id: recipes[2].id, quantity: "2 ounces"},
  {name: ingredients[4].name, ingredient_id: ingredients[4].id, recipe_id: recipes[2].id, quantity: "4 ounces"}])

reviews = Review.create([{title: "Test comment", content: "Lorem ptsd rwehf sfhsefs dfsufhe shef sss", user_id: users[0].id, recipe_id: recipes[0].id}])
