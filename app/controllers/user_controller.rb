class UserController < ApplicationController

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
			@error_message = true
			erb :'user/login'
		end
	end

	get '/users/logout' do
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
			@error_message = "Oops! There's a problem with the info you entered. Please try again."
			# do  something better here
		end
	end

	get '/users/:id' do
		redirect to('/') if current_user.id.to_s != params[:id]
		@user = current_user
		@decks = Deck.where(:user_id => @user.id)
		session[:deck_id] = nil

		erb :'user/show'
	end
	
	get '/*' do
		erb :not_found
	end
end