class RecipesController < ApplicationController
  # before_action :require_logged_in

  def index
    @recipes = Recipe.all
  end

  def new
    @recipe = current_user.recipes.build
    @ingredients = Ingredient.all
  end

  def show
    find_recipe
    @recipe_ingredient = RecipeIngredient.find(params[:id])
    # binding.pry
    # @ingredient = Ingredient.find(params[:id])
  end

  def upvote
    find_recipe
    @recipe.update(:upvotes => @recipe.upvotes+1)
    redirect_to recipe_path(@recipe)
  end

  def downvote
    find_recipe
    @recipe.update(:upvotes => @recipe.upvotes-1)
    redirect_to recipe_path(@recipe)
  end

  def create
    # binding.pry
    @recipe = current_user.recipes.build(recipe_params)

    if @recipe.valid?
      @recipe.save
      redirect_to @recipe
    else
      @ingredients = Ingredient.all
      render :new
    end
  end

  def edit
    find_recipe
    @ingredients = Ingredient.all
  end

  def update
    find_recipe
    @recipe.update(recipe_params)
    if @recipe.valid?
      redirect_to recipe_path(@recipe)
    else
      @ingredients = Ingredients.all
      render :edit
    end
  end

  def destroy
    find_recipe
    @recipe.destroy
    redirect_to recipes_path
  end


  private

  def recipe_params
    params.require(:recipe).permit(:name, :description, :directions, recipe_ingredients_attributes: [ :quantity, :ingredient_id, ingredient_attributes: [ :name ] ])
  end

  def find_recipe
    @recipe = Recipe.find(params[:id])
    if !@recipe
      redirect_to user_path(@current_user)
    end
  end
end
