class RecipeSerializer < ActiveModel::Serializer
  attributes :id, :name, :directions, :description, :upvotes, :review_list
  has_many :reviews
  has_many :recipe_ingredients
  belongs_to :user

  def review_list
    object.reviews.map do |review| {
      id: review.id,
      user: {
        id: review.user_id,
        name: User.find(review.user_id).name
      },
      title: review.title,
      content: review.content
      }
    end
  end

  def recipe_ingredients
    object.recipe_ingredients.map do |ri| {
      id: ri.ingredient.id,
      quantity: ri.quantity,
      name: ri.ingredient.name
      }
    end
  end

  # def ingredient_list
  #   object.recipe_ingredients.map do |ri| {
  #     id: ri.id,
  #     user: {
  #       id: ri.user_id,
  #       name: User.find(ri.user_id).name
  #     },
  #     name: ri.name,
  #     quantity: ri.quantity
  #     }
  #   end
  # end

end
