class UserController < ApplicationController

	get '/users/login' do
		redirect to("users/#{current_user.id}") if logged_in?

		erb :'user/login'
	end

	post '/users/login' do
		@user = User.find_by(:username => params[:username])
		if @user && @user.authenticate(params[:password])
			session[:user_id] = @user.id
			redirect to("/users/#{@user.id}")
		else
			flash[:error] = "Your username or password do not match our records.  Please try again or&nbsp;<a href='/users/new'>Register</a>."
			redirect to('/users/login')
		end
	end

	get '/users/logout' do
		session.clear

		redirect to('/')
	end

	get '/users/new' do
		erb :'user/register'
	end

	post '/users' do
		@user = User.new(:username => params[:username], :password => params[:password])
		if @user.save
			session[:user_id] = @user.id
			redirect to("/users/#{@user.id}")
		else
			error = @user.errors
			flash[[:error]] = "Error: " + error.full_messages.to_sentence
			redirect to('/users/new')
		end
	end

	get '/users/:id' do
		access_forbiden?(params[:id])
		@user = current_user
		@decks = Deck.where(:user_id => @user.id)

		erb :'user/show'
	end
	
	get '/*' do
		@user = current_user
		erb :not_found
	end

end