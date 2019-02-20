class RecipeIngredientSerializer < ActiveModel::Serializer
  attributes :id, :quantity
  belongs_to :ingredient
  belongs_to :recipe

  def name
    return ingredient.name
  end
end
