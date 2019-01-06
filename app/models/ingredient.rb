class Ingredient < ApplicationRecord
  has_many :recipe_ingredients
  has_many :recipes, :through => :recipe_ingredients
  validates :name, presence: true, uniqueness: true
  before_save { |ingredient| ingredient.name = ingredient.name.titleize }

end
