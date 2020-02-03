require_relative 'recipe'
require 'csv'

# this is the DB
class Cookbook
  def initialize(csv_file_path)
    @csv = csv_file_path # CSV file is defined on app.rb
    @recipes = []
    load_csv
  end

  def all
    @recipes
  end

  def find_recipe(index)
    @recipes[index]
  end

  def add_recipe(recipe)
    @recipes << recipe
    # CSV.open(@csv, 'a') do |csv|
    #   csv << [recipe]
    # end
    save_csv
  end

  def update_recipe(recipe)
    save_csv
  end

  def remove_recipe(recipe_index)
    @recipes.delete_at(recipe_index)
    # CSV.open(@csv, 'w') do |csv|
    #   @recipes.each do |recipe|
    #     csv << [recipe]
    #   end
    # end
    save_csv
  end

  private

  def load_csv
    CSV.foreach(@csv) do |row|
      @recipes << Recipe.new(row[0], row[1], row[2], row[3], row[4] == "true")
    end
  end

  def save_csv
    CSV.open(@csv, 'wb') do |csv|
      @recipes.each do |recipe|
        csv << [recipe.name, recipe.description, recipe.prep_time, recipe.difficulty, recipe.done]
      end
    end
  end
end
