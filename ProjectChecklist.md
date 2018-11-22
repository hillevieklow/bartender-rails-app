# Rails Project Checklist of Requirements

## A summary of the application
Bartender  - A rails app that allows users to add cocktails recipes to a database, and search for recipes after ingredients.

## What will your models and associations be and why? You will need a has_many and belongs_to relationship as well as a many to many relationship.
Recipe: has_many :recipe_ingredients; has_many :ingredients, :through => :recipe_ingredients; belongs_to :user
Ingredient: has_many :recipe_ingredients; has_many :recipes, through => recipe_ingredients
RecipeIngredient: belongs_to :recipe, belongs_to :ingredient
User: has_many :recipes

## How will you implement a user submittable attribute on the join table of the many to many relationship?
RecipeIngredient; submittable attribute: quantity

## What it is an ActiveRecord scope method and what is your implementation plan?
Scope method returns activerecord::relation object, like: “SELECT recipes WHERE ingredient = ?”

## What validations will you have for your models?
User signup validations, validations for recipe name (unique) and ingredients (unique), that quantity is not < 0


## How will you implement an authentication system?



## What 3rd party login service will you use?
facebook

## With the way your models are setup what nested routes will you use to meet the requirement?
Resources :users
Resources :recipes
Recources :recipe_ingredients do
	Resources :ingredients
