class ReviewsController < ApplicationController
  before_action :set_recipe

  def index
    @reviews = @recipe.reviews
    # render :layout => false
    render :json => @reviews
  end

  private
  def set_recipe
    @recipe = Recipe.find(params[:recipe_id]) # loads recipe into @recipe variable
  end
end
