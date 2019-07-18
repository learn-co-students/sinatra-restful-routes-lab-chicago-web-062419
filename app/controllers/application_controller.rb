class ApplicationController < Sinatra::Base
  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  # code actions here!
  #Renders the form the fill out a new recipe
  get '/recipes/new' do
    erb :new
  end
  #takes the input from the post and creates a new instance of a recipe
  #redirects us to the page relating to the id
  post '/recipes' do
    @recipe = Recipe.create(name: params[:name], ingredients: params[:ingredients], cook_time: params[:cook_time])
    redirect :"/recipes/#{@recipe.id}"
  end

  #shows us all of the recipes in the database / stored in index
  get '/recipes' do
    @recipes = Recipe.all

    erb :index
  end

  #1. Capture the ID that is in the URL
  #2. Find that recipe that relates to this ID
  #3. Render the show page to see this instance
  get '/recipes/:id' do
    id = params[:id] #catch the id and create a variable
    @recipe = Recipe.find(id)

    erb :show
  end
  #1. Capture the ID that is in the URL
  #2. Show the edit page which is another form with the PATCH method
  get '/recipes/:id/edit' do
    @recipe = Recipe.find(params[:id])

  erb :edit
  end

  #1. We want to patch the instance we are changing, therefore the route is the instance id route
  #2. With the new details, we want to catch these all and update our instance with the new information that has changed
  #.create method will save the information to the database
  #3. After the changes have been made, we want to redirect the viewer to the page displaying the new instances details

  patch '/recipes/:id' do
    @recipe = Recipe.find(params[:id])
    @recipe.update(name: params[:name], ingredients: params[:ingredients], cook_time: params[:cook_time])

  redirect to :"/recipes/#{@recipe.id}"
  end

  #1. Capture the id of the instance we want to delete
  #2. Destroy it 
  #3. Redirect to the homepage for a list of all recipes (because the one you deleted wont exist anymore)
  delete '/recipes/:id' do
    @recipe = Recipe.find(params[:id])
    @recipe.destroy
    redirect to :'/recipes'
  end
end