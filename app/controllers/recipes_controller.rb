class RecipesController < ApplicationController
  before_action :require_logged_in

  def index
    @recipes = Recipe.all
    respond_to do |f|
      f.html {render :index}
      f.json {render json: @recipes}
    end
  end

  def new
    @recipe = current_user.recipes.build
    # @recipe.recipe_ingredients.build
    3.times do
      @recipe.recipe_ingredients.build.build_ingredient
    end
    @ingredients = Ingredient.all
  end

  def show
    find_recipe
    @recipe_ingredient = RecipeIngredient.find(params[:id])
    if current_user
      @review = current_user.reviews.build(recipe: @recipe)
    end


    respond_to do |f|
      f.html
      f.json {render json: @recipe}
    end
    # @reviews = @recipe.reviews
    # @review = Review.new
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

    if @recipe.save
      redirect_to @recipe
    else
      @ingredients = Ingredient.all
      3.times do
        @recipe.recipe_ingredients.build.build_ingredient
      end
      render :new
      # redirect_to new_recipe_path #render makes form input for ingredients disappear
    end
  end

  def edit
    find_recipe
    if current_user != @recipe.user
      redirect_to :back, alert: "You must be the author in order to delete a story."
    else
      @ingredients = Ingredient.all
    end
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
    if current_user != @recipe.user
      redirect_to :back, alert: "You must be the author in order to delete a story."
    else
      @recipe.destroy
      redirect_to recipes_path
    end
  end

  def next_recipe
    @recipe = Recipe.find(params[:id])
    @next_recipe = @recipe.next
    render json: @next_recipe
  end

  def previous_recipe
    @recipe = Recipe.find(params[:id])
    @previous_recipe = @recipe.previous
    render json: @previous_recipe
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
