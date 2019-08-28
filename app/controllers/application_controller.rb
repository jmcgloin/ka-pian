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
		@error_message = nil
		erb :login
	end

	post '/users/login' do
		@user = User.find_by(:username => params[:username])
		if @user && @user.authenticate(params[:password])
			session[:user__id] = @user.id
			redirect to("/users/#{@user.id}")
		else
			@error_message = "Oops! There's a probelem with the info you entered. Please try again or <a href='/users/new'>Register</a>."
			erb :login
		end
	end

	get '/users/new' do
		@error_message = nil
		erb :register
	end

	post '/users' do
		@user = User.new(:username => params[:username], :password => params[:password])
		binding.pry
		if @user.save
			session[:user_id] = @user.id
			redirect to("/users/#{@user.id}")
		else
			@error_message = "Oops! There's a probelem with the info you entered. Please try again."
			# do  something better here
		end
	end

	get '/users/:id' do
		# make sure this user is currently logged in
		# then show their account
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