class Recipe < ApplicationRecord
  has_many :recipe_ingedients
  has_many :ingredients, :through => :recipe_ingedients
  belongs_to :user
end
