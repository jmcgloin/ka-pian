# Next todo:
# views, deck, edit
# 
# 
# 
# 

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
		if correct_user?(params[:id])
			@user = current_user
			@decks = Deck.where(:user_id => @user.id)
			erb :'user/show'
		else
			redirect to('/')
		end
	end

	get '/users/:id/decks/new' do
		if correct_user?(params[:id])
			@user = current_user
			erb :'deck/new'
		else
			redirect to('/')
		end
	end

	post '/users/:id/decks/new' do
		if correct_user?(params[:id])
			@user = current_user
			@deck = Deck.create(
				:deck_name => params[:deck_name],
				:keywords => params[:keywords],
				:shareable => params[:shareable],
				:user_id => @user.id
				)

			redirect to("/users/#{@user.id}") # change this to deck/add cards page
		else
			redirect to('/')
		end
	end

	get '/users/:id/decks/:did/edit' do
		@user = current_user
		@deck = Deck.find(params[:did])
		erb :'deck/edit'
	end

	put '/users/:id/decks/:did/edit' do
		@deck = Deck.find(params[:did])
		@deck.update(
			:deck_name => params[:deck_name],
			:keywords => params[:keywords],
			:shareable => params[:shareable]
			)
		# binding.pry

		redirect to("/users/#{@deck.user_id}")
	end

	delete '/users/:id/decks/:deck_id/delete' do
		if correct_user?(params[:id])
			Deck.find(params[:deck_id]).destroy

			redirect to("users/#{params[:id]}")
		end
	end

	helpers do
	  def logged_in?
	    !!session[:user_id]
	  end

	  def current_user
	    User.find(session[:user_id])
	  end

	  def correct_user?(id)
	  	logged_in? && (current_user.id.to_s == id.to_s)
	  end
	end

end