class IngredientsController < ApplicationController
  def index
    @ingredients = Ingredient.all
  end

  def show
    find_recipe_ingredient_and_ingredient
    # binding.pry
  end


  private

  def find_recipe_ingredient_and_ingredient
    @ingredient = Ingredient.find_by(params[:id])
    @recipe_ingredient = RecipeIngredient.find_by(params[:id])
  end


  def ingredient_params
    params.require(:ingredient).permit(:name)
  end


end
