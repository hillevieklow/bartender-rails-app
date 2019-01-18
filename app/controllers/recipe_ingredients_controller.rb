class RecipeIngredientsController < ApplicationController
  before_action :require_logged_in

  def new
    @recipe = Recipe.find(params[:recipe_id])
    @ingredients = Ingredient.all
    @recipe_ingredient = @recipe.recipe_ingredients.build
    @recipe_ingredient.build_ingredient
  end


  def create
    @recipe = Recipe.find(params[:recipe_id])
    @ingredients = Ingredient.all
    @recipe_ingredient = @recipe.recipe_ingredients.build(recipe_ingredient_params)
    @recipe_ingredient.build_ingredient
    #binding.pry
    if @recipe.save
      redirect_to recipe_path(@recipe)
    else
      @ingredients = Ingredient.all
      render :new
    end
  end


  private

  def recipe_ingredient_params
    params.require(:recipe_ingredient).permit(:quantity, :ingredient_id, ingredient_attributes: [ :name ])
  end

  def find_recipe_ingredient
    @recipe_ingredient = RecipeIngredient.find(params[:id])
    if !@recipe_ingredient
      redirect_to user_path(@current_user)
    end
  end

end
