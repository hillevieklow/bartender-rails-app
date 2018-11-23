class RecipesController < ApplicationController
  before_action :require_logged_in, except: [:index, :show]

  def index
    @recipes = Recipe.all
  end

  def new
    @recipe = current_user.recipes.build
  end

  def create
    binding.pry
    @recipe = current_user.recipes.build(recipe_params)

    if @recipe.valid?
      @recipe.save
    else
      render :new
    end
  end

  private

  def recipe_params
    params.require(:recipe).permit(:name, :description, :direction, recipe_ingredients_attributes: [ :quantity, ingredient_attributes: [ :name ] ])
  end

  def find_recipe
    @recipe = Recipe.find(params[:id])
    if !@recipe
      redirect_to user_path(@current_user)
    end
  end
end
