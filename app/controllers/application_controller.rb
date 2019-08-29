require "./config/environment"

class ApplicationController < Sinatra::Base

	configure do
	  set :views, "app/views"
	  enable :sessions
	  set :session_secret, "password_security"
	end

	get '/' do
		erb :welcome
	end

	get '/users/login' do
		redirect to("users/#{current_user.id}") if logged_in?
		@error_message = nil
		erb :'user/login'
	end

	post '/users/login' do
		@user = User.find_by(:username => params[:username])
		if @user && @user.authenticate(params[:password])
			session[:user_id] = @user.id
			redirect to("/users/#{@user.id}")
		else
			@error_message = "Oops! There's a probelem with the info you entered. Please try again or <a href='/users/new'>Register</a>."
			erb :'user/login'
		end
	end

	post '/users/logout' do
		session.clear
		redirect to('/')
	end

	get '/users/new' do
		@error_message = nil
		erb :'user/register'
	end

	post '/users' do
		@user = User.new(:username => params[:username], :password => params[:password])
		if @user.save
			session[:user_id] = @user.id
			redirect to("/users/#{@user.id}")
		else
			@error_message = "Oops! There's a probelem with the info you entered. Please try again."
			# do  something better here
		end
	end

	get '/users/:id' do
		if logged_in?
			@user = current_user
			@decks = Deck.find_by(:user_id => @user.id)
			erb :'user/show'
		else
			redirect to('/')
		end
	end



	helpers do
	  def logged_in?
	    !!session[:user_id]
	  end

	  def current_user
	    User.find(session[:user_id])
	  end
	end

end