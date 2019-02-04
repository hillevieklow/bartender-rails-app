class ReviewsController < ApplicationController
  before_action :set_recipe

  def index
    @reviews = @recipe.reviews
  end

  private
  def set_recipe
    @recipe = Recipe.find(params[:recipe_id]) # loads recipe into @recipe variable
  end
end
