# Rails Project Checklist of Requirements

## A summary of the application
Bartender - A rails app that allows users to add cocktails recipes to a database, and search for cocktail recipes after ingredients. Say for instance you would like to find all recipes including "Banana", you can retrieve those.

## What will your models and associations be and why? You will need a has_many and belongs_to relationship as well as a many to many relationship.
---Recipe---
has_many :recipe_ingredients
has_many :ingredients, :through => :recipe_ingredients
belongs_to :user

  t.string :name
  t.text :description
  t.text :directions
  t.integer :user_id
  t.integer :upvotes, :default => 0

---Ingredient---
has_many :recipe_ingredients
has_many :recipes, through => recipe_ingredients

  t.string :name

---RecipeIngredient--- (JOIN)
belongs_to :recipe
belongs_to :ingredient

  t.integer :recipe_id
  t.integer :ingredient_id
  t.integer :quantity

---User---
has_many :recipes

  t.string :name
  t.string :password_digest

## How will you implement a user submittable attribute on the join table of the many to many relationship?
RecipeIngredient; submittable attribute: quantity

## What it is an ActiveRecord scope method and what is your implementation plan?
Scope method returns activerecord::relation object, like: SELECT recipes WHERE ingredient = "Banana"

## What validations will you have for your models?
User signup validations, validations for recipe name (unique) and ingredients (unique), that quantity is not < 0.. use .valid? before saving into database


## How will you implement an authentication system?
- Login, password
- One can only edit ones own recipes
- One can create but not delete ingredients


## What 3rd party login service will you use?
facebook

## With the way your models are setup what nested routes will you use to meet the requirement?
Resources :users
Resources :recipes do
	Resources :ingredients
Recources :ingredients


## Questions
1. I need in my form be able to create a new recipe, but also add ingredients.. and ingredients I want to save in a different database. One should be able to pick from ingredients that already exist, OR, create new ones. For each ingredient in a recipe, (recipeingredient) needs to allow for quantity aswell. How do I implement this?
- How do I create a form that allows to save in two different databases?
- Should I just simplify it somehow?

2. How do I delete the recipe residue on recipe index page..





look into reject_if-ish in model; allows to avoid saving empty fields
