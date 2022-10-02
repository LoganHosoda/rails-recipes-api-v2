class CreateRecipes < ActiveRecord::Migration[7.0]
  def change
    create_table :recipes do |t|
      t.integer :recipe_id
      t.jsonb :payload, null: false, default: '{}'
    end
    add_index :recipes, :payload, using: :gin
  end
end
