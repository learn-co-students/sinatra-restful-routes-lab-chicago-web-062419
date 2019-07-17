require 'pry'
class ApplicationController < Sinatra::Base
  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  # code actions here!

  #index
  get '/' do
    redirect to '/recipes'
  end 

  get '/recipes' do
    @recipes = Recipe.all
    erb :index
  end

  #create
  get '/recipes/new' do
    erb :new
  end

  post '/recipes' do
    @recipe = Recipe.create(params)
    
    redirect to "/recipes/#{@recipe.id}"
  end

  #read
  get '/recipes/:id' do
    @recipe = Recipe.find(params[:id])
    @name = @recipe.name
    @ingredients = @recipe.ingredients
    @cook_time = @recipe.cook_time
    erb :show
  end

  #edit 
  get '/recipes/:id/edit' do
    @recipe = Recipe.find(params[:id])
    @ingredients = @recipe.ingredients
    erb :edit
  end

  #update
  patch '/recipes/:id' do
    @recipe = Recipe.find(params[:id])
    @recipe.name = params[:name]
    @recipe.ingredients = params[:ingredients]
    @recipe.cook_time = params[:cook_time]
    @recipe.save
    
    redirect to "/recipes/#{@recipe.id}"
  end

  #destroy
  delete '/recipes/:id' do
    @recipe = Recipe.find(params[:id])
    @recipe.delete
    redirect to "/recipes"
  end
end
