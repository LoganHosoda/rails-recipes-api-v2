class Recipe < ApplicationRecord
  # Returns hash of recipe names for accessing database

  def self.recipe_names
    @recipes = Recipe.all
    @recipe_name_hash = {}
    @counter = 0
    @recipes.each do |recipe|
      @recipe_name_hash[recipe.payload['name']] = @counter
      @counter += 1
    end
    @recipe_name_hash
  end

  # Custom JSON display for recipes#index
  def self.display_recipes
    @recipes = Recipe.all
    @recipe_array = []
    @recipes.each do |recipe|
      @recipe_array.push(recipe.payload['name'])
    end
    @recipes = { "recipeNames": @recipe_array }
  end

  # Custom JSON display for recipes#show
  def self.display_ingredients(recipe)
    @ingredients = { 'details': {
      'ingredients': recipe.payload['ingredients'],
      'numSteps': recipe.payload['instructions'].length
    } }
  end

  def self.get_recipe(params)
    @recipes = Recipe.all
    @recipe = {}
    @recipes.each do |recipe|
      if recipe.payload['name'].include?(params['name'])
        @recipe = recipe
      end
    end
    @recipe
  end
end
