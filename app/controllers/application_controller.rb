require "./config/environment"

class ApplicationController < Sinatra::Base

	configure do
	  set :views, "app/views"
	  enable :sessions
	  set :session_secret, "password_security"
	  set :public_folder, "./public"
	  register Sinatra::Flash
	end


	get '/' do
		headers "Cache-Control" => "no-cache"
		logged_in? && (redirect to("/users/#{current_user.id}"))
		@home = true
		erb :welcome
	end

	helpers do
	  def logged_in?
	    !!current_user
	  end

	  def current_user
	    User.find_by_id(session[:user_id])
	  end

	  def current_deck
	  	Deck.find_by_id(session[:deck_id])
	  end

	  def access_forbiden?(user_id)
	  	if !logged_in?
	  		session.clear
	  		redirect to('/')
	  	elsif user_id.to_s != current_user.id.to_s
	  		binding.pry
	  		session[:deck_id] = nil
	  		redirect to("users/#{current_user.id}")
	  	end
	  end
	end

end