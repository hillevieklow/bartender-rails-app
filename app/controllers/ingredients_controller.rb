class IngredientsController < ApplicationController
  before_action :require_logged_in

  def index
    @ingredients = Ingredient.all
  end

  def show
    find_recipe_ingredient_and_ingredient
    # binding.pry
  end


  private

  def find_recipe_ingredient_and_ingredient
    # binding.pry
    @ingredient = Ingredient.find(params[:id])
    @recipe_ingredient = RecipeIngredient.find(params[:id])
  end


  def ingredient_params
    params.require(:ingredient).permit(:name)
  end


end
