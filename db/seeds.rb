# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


ingredients = Ingredient.create([{name: 'carrot'}, {name: 'banana'}, {name: 'vodka'}])

users = User.create([
  {email: 'hello@my.com', name: 'Hanna', password: 'Test'},
  {email: 'coco@my.com', name: 'Geoffery', password: 'Test'},
  {email: 'nice@my.com', name: 'Gustaaf', password: 'Test'}])

recipes = Recipe.create([{name: 'Vodka Redbull', description: 'El Clasico', directions: 'stir', user_id: users[0].id, upvotes: 10},
  {name: 'Gin Tonic', description: 'El Mejor Clasico', directions: 'fry', user_id: users[1].id, upvotes: 5},
  {name: 'Bloody Mary', description: 'Clasico', directions: 'Bend and snap', user_id: users[2].id, upvotes: 11}])

recipe_ingredients = RecipeIngredient.create([{name: ingredients[0].name, ingredient_id: ingredients[0].id, recipe_id: recipes[0].id, quantity: 3},
  {name: ingredients[1].name, ingredient_id: ingredients[1].id, recipe_id: recipes[1].id, quantity: 1},
  {name: ingredients[2].name, ingredient_id: ingredients[2].id, recipe_id: recipes[2].id, quantity: 5}])
