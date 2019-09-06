require "./config/environment"

class ApplicationController < Sinatra::Base

	configure do
	  set :views, "app/views"
	  enable :sessions
	  set :session_secret, "password_security"
	end

	get '/' do
		headers "Cache-Control" => "no-cache"
		logged_in? && (redirect to("/users/#{current_user.id}"))
		erb :welcome
	end

	not_found do
	  status 404
	  # erb :oops  write this later TODO
	end

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
	    !!session[:user_id] && User.find(session[:user_id])
	  end

	  def current_deck
	  	Deck.find(session[:deck_id])
	  end

	  def current_info
	  	[current_user, current_deck]
	  end

	  def correct_user?(id)
	  	logged_in? && (current_user.id.to_s == id.to_s)
	  end
	  
	  def access_forbiden?(user_id)
	  	redirect to("/users/#{current_user.id}") if user_id != current_user.id
	  end
	end

end