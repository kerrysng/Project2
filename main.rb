# require 'pry'
require 'sinatra'
# require 'sinatra/reloader'
require 'pg'
require_relative 'database_config'
require_relative 'models/user'
require_relative 'models/photo'
require_relative 'models/comment'


enable :sessions

helpers do
  def current_user
    User.find_by(id: session[:user_id])
  end
  def logged_in? #should return a boolean
    #  current_user != nil
    !!current_user

  end
end

after do
  ActiveRecord::Base.connection.close
end

get '/' do
  erb :index
end

get '/exercises/new' do
  erb :new
end

get '/galleries/new' do
  @galleries = Photo.all
  erb :new
end

post '/galleries' do
  photo = Photo.new
  photo.name = params[:name]
  photo.image_url = params[:image_url]

  if photo.save
    redirect '/'
   else
    erb :new
 end
end

put '/galleries/:id' do
  redirect '/sessions/new' if !logged_in?

  photo = Photo.find(params[:id])
  photo.name = params[:name]
  photo.image_url = params[:image_url]
  photo.save
  redirect "/galleries/#{params[:id]}"
end

get '/galleries/:id' do
  @photo = Photo.find(params[:id])
  @comments = @photo.comments
  erb :show
end

delete '/galleries/:id' do
  photo = Photo.find(params[:id])
  photo.destroy

  redirect '/'
end

get '/signups/new' do
  erb :sign_up
end

post '/signups' do
  user = User.new(email: params[:email], password: params[:password])
  user.save
  session[:user_id] = user.id
  redirect '/sessions/new'
end

get '/sessions/new' do
  erb :login
end

post '/session' do
  user = User.find_by(email: params[:email])
  if user && user.authenticate(params[:password])
    session[:user_id] = user.id
    redirect '/'
  else
    erb :login
  end

end

post '/comments' do
  comment = Comment.new
  comment.body = params[:body]
  comment.photo_id = params[:photo_id]
  if comment.save
    redirect "/galleries/#{params[:photo_id]}"
  else
    erb :show
  end
end

get '/logout' do
  session[:user_id] = nil
  redirect '/'
end
