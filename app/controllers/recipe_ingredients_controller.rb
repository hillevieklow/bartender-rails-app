class RecipeIngredientsController < ApplicationController

  def new
    @recipe_ingredient = current_user.recipe_ingredients.build
  end


  def create
    @recipe_ingredient = current_user.recipe_ingredient.build(recipe_ingredient_params)
    if @recipe_ingredient.valid?
      @recipe_ingredient.save
    else
      render :new
    end
  end

  private

  def recipe_ingredient_params
    params.require(:recipe_ingredient).permit(:name, :quantity)
  end

  def find_recipe_ingredient
    @recipe_ingredient = RecipeIngredient.find(params[:id])
    if !@recipe_ingredient
      redirect_to user_path(@current_user)
    end
  end

end
