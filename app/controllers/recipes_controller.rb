class RecipesController < ApplicationController
  before_action :set_recipe, only: %i[show update destroy]

  # GET /recipes
  def index
    @recipes = Recipe.display_recipes
    render json: @recipes
  end

  # GET /recipes/details/:id
  def show
    if @is_valid
      @details = Recipe.display_ingredients(@recipe)
    else
      @details = {}
    end
    render json: @details
  end

  # POST /recipes
  def create
    if name_exists
      render json: {
        status: 'Error',
        message: 'Recipe already exists'
      }, status: 400
    else
      @recipe = Recipe.create!(payload: recipe_params)
      render json: {
        status: 'OK',
        message: 'Recipe created!'
      }, status: 201
    end
  end

  # PATCH/PUT /recipes/1
  def update
    if name_exists
      @recipe = Recipe.get_recipe(params)
      @recipe.update(payload: recipe_params)
      #@recipe.update(payload: recipe_params)
      render json: @recipe
    else
      render json: {
        status: 'Error',
        message: 'Recipe does not exist'
      }, status: 404
    end
  end

  # DELETE /recipes/1
  def destroy
    @recipe.destroy
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_recipe
    @recipes = Recipe.all
    @recipe_names = Recipe.recipe_names
    @is_valid = valid_id(@recipe_names)
    if @is_valid
      @recipe = @recipes[@recipe_names[params[:id]]]
    else
      @recipe = {}
    end
  end

  # Checks database for recipe name
  def valid_id(recipes)
    recipes.include?(params[:id])
  end

  def name_exists
    Recipe.recipe_names.include?(params['name'])
  end

  # Only allow a list of trusted parameters through.
  def recipe_params
    @recipe_payload = {}
    if params['name']
      @recipe_payload['name'] = params['name']
    end
    if params['ingredients']
      @recipe_payload['ingredients'] = params['ingredients']
    end
    if params['instructions']
      @recipe_payload['instructions'] = params['instructions']
    end
    @recipe_payload
  end
end
