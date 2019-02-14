class Recipe < ApplicationRecord
  has_many :recipe_ingredients
  has_many :reviews
  has_many :ingredients, :through => :recipe_ingredients
  belongs_to :user

  validates :name, presence: true, uniqueness: true
  validates :recipe_ingredients, presence: true
  validates :description, presence: true
  validates :directions, presence: true


  before_save { |recipe| recipe.name = recipe.name.titleize }
  accepts_nested_attributes_for :recipe_ingredients, allow_destroy: true,
 reject_if: proc { |attributes| attributes['quantity'].blank? }

 def self.most_popular
   self.all.order(upvotes: :desc)
 end

 def previous
   if previous_recipe = self.class.where("id < ?", id).last
     previous_recipe
   else
     Recipe.last
   end
 end

 def next
   if next_recipe = self.class.where("id > ?", id).first
     next_recipe
   else
     Recipe.first
   end
 end

end
