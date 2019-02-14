class ReviewsController < ApplicationController
  before_action :set_recipe

  def create
    @review = current_user.reviews.build(review_params)
    @review.recipe = @recipe
    if @review.save
      render json: @review, status: 201
    else
      render json: {errors: @review.errors.full_messages}, status: 400
    end
  end

  private
  def set_recipe
    @recipe = Recipe.find(params[:recipe_id])
  end

  def review_params
    params.require(:review).permit(:content, :title, :user_id, :recipe_id)
  end
end
