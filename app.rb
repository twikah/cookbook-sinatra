require "sinatra"
require "sinatra/reloader" if development?
require "pry-byebug"
require "better_errors"

require_relative 'cookbook'

csv_file   = File.join(__dir__, 'recipes.csv')
cookbook   = Cookbook.new(csv_file)

set :bind, '0.0.0.0'

configure :development do
  use BetterErrors::Middleware
  BetterErrors.application_root = File.expand_path('..', __FILE__)
end

get '/' do
  @recipes = cookbook.all
  erb :index
end

get '/new' do
  erb :new
end

post '/recipes' do
  name = params["name"]
  description = params["description"]
  prep_time = params["prep_time"]
  difficulty = params["difficulty"]
  recipe = Recipe.new(name, description, prep_time, difficulty)
  @recipes = cookbook.add_recipe(recipe)
  redirect '/'
end

get '/recipes/:index' do
  cookbook.remove_recipe(params[:index].to_i)
  redirect '/'
end

get '/about' do
  erb :about
end

get '/team/:username' do
  puts params[:username]
  "The username is #{params[:username]}"
end
