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