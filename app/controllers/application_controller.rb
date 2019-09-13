require "./config/environment"

class ApplicationController < Sinatra::Base

	configure do
	  set :views, "app/views"
	  enable :sessions
	  set :session_secret, "password_security"
	  set :public_folder, "/public"
	end


	get '/' do
		headers "Cache-Control" => "no-cache"
		logged_in? && (redirect to("/users/#{current_user.id}"))
		@home = true
		erb :welcome
	end

	# not_found do
	#   status 404
	#   # erb :oops  write this later TODO
	# end

	# error do
	# 	binding.pry
	# 	redirect '/'
	# end

	# error ActiveRecord::RecordNotFound do
	#   redirect '/'
	# end

	helpers do
	  def logged_in?
	    !!session[:user_id]
	  end

	  def current_user
	    logged_in? && User.find_by(:id => session[:user_id])
	  end

	  def current_deck
	  	!!session[:deck_id] && Deck.find_by(:id => session[:deck_id])
	  end

	  def access_forbiden?(user_id)
	  	if !logged_in?
	  		redirect to('/')
	  	elsif user_id != current_user.id
	  		redirect to("/users/#{current_user.id}")
	  	else
	  		current_user
	  	end
	  end
	end

end