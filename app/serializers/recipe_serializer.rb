class RecipeSerializer < ActiveModel::Serializer
  attributes :id, :name, :directions, :description, :review_list
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

end
