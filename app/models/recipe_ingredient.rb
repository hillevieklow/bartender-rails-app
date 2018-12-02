class RecipeIngredient < ApplicationRecord
  belongs_to :recipe
  belongs_to :ingredient
  validates :quantity, presence: true

  accepts_nested_attributes_for :ingredient, allow_destroy: true,
 reject_if: proc { |attributes| attributes['name'].blank? }


end
