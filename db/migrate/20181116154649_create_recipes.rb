class CreateRecipes < ActiveRecord::Migration[5.2]
  def change
    create_table :recipes do |t|
      t.string :name
      t.text :description
      t.text :directions
      t.integer :user_id
      t.integer :upvotes, :default => 0
      t.timestamps
    end
  end
end
