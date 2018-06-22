require "rack-flash"

class UsersController < ApplicationController

  use Rack::Flash

  get '/signup' do
    if logged_in?
      redirect "/appointments"
    else
      erb :'/users/create_user'
    end
  end

  post '/signup' do
    @user = User.new(params)
    if @user.save
      session[:id] = @user.id
      redirect :'/appointments'
    else
      flash[:message] = "Either username/name/email already exists. Please try again!"
      redirect :'/signup'
    end
  end

  get '/login' do
    if logged_in?
      redirect '/appointments'
    else
      erb :'/users/login'
    end
  end

  post '/login' do
    @user = User.find_by(username: params[:username])
    if @user && @user.authenticate(params[:password])
      session[:id] = @user.id
      redirect '/appointments'
    else
      flash[:message] = "Could not find username and/or password!"
      redirect '/login'
    end
  end
end
