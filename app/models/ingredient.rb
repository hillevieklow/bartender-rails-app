class Ingredient < ApplicationRecord
  has_many :recipe_ingedients
  has_many :recipes, :through => :recipe_ingedients
end
