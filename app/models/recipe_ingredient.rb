class RecipeIngredient < ApplicationRecord
  belongs_to :recipe
  belongs_to :ingredient

  def recipe_name
    Recipe.find(self.recipe_id).name
  end

  def ingredient_id
    Recipe.find(self.recipe_id).ingredient_id
  end

end
