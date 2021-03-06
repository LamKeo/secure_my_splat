require 'bundler'
Bundler.require

#establishing connection to postgresql db
ActiveRecord::Base.establish_connection(
  :database => 'bee_crypt_bzz',
  :adapter => 'postgresql'
)

# this will go in ApplicationController
enable :sessions #this is how you enable a session!

#helper method to see if username exists!
#does_user_exist(params[:user_name])
def does_user_exist(username)
  user = Account.find_by(:user_name => username)
  if user
    return true
  else
    return false
  end
end

#does our user have access to something?
def authorization_check
  if session[:current_user] == nil
    redirect '/not_authorized'
   #return false
  else
    return true
  end
end

#basic template routes
get '/' do
  #for any resource I want to protect
  #i perform an authorization_check
  authorization_check
  @user_name = session[:current_user].user_name
  #return some resource
  #return {:hello => 'world'}.to_json
  erb :index
end

get '/not_authorized' do
  erb :not_authorized
end

#registration for user
get '/register' do
  #render a view for register
  erb :register
end

post '/register' do
  p params
  #check if the user someone is trying to register exists or NOT
  if does_user_exist(params[:user_name]) == true
    return {:message => 'user exists'}.to_json
    #return erb :view_name
  end

  #if we make it this far the user does not exist
  #lets make it!
  user = Account.create(user_email: params[:user_email], user_name: params[:user_name], password: params[:password])

  p user

#session is a hash!
  session[:current_user] = user

  redirect '/' #instead of calling a view to render
  #I want to redirect to a route
end

#login
get '/login' do
  erb :login
end

post '/login' do
  user = Account.authenticate(params[:user_name], params[:password])
    if user
      session[:current_user] = user
      redirect '/'
    else
      @message = 'Your password or account is incorrect'
      erb :login
    end
end

#logout
get '/logout' do
  authorization_check
  session[:current_user] = nil
  redirect '/'
end
