class DeckController <  ApplicationController

	get '/decks/new' do
		@user = current_user
		erb :'deck/new'
	end

	post '/decks/new' do
		@user = current_user
		@deck = Deck.create(
			:deck_name => params[:deck_name],
			:keywords => params[:keywords],
			:shareable => params[:shareable],
			:user_id => @user.id
			)
		session[:deck_id] = @deck.id
		redirect to("/users/#{@user.id}") # change this to deck/add cards page
	end

	get '/decks/:did/edit' do
		@deck = Deck.find(params[:did])
		redirect to('/') if @deck.user_id != current_user.id
		# add a check if a deck id that doesn't exist is entered directly to uri
		@user = current_user
		erb :'deck/edit'
	end

	put '/decks/:did/edit' do
		@deck = Deck.find(params[:did])
		redirect to('/') if @deck.user_id != current_user.id
		# add a check if a deck id that doesn't exist is entered directly to uri
		@deck = Deck.find(params[:did])
		@deck.update(
			:deck_name => params[:deck_name],
			:keywords => params[:keywords],
			:shareable => params[:shareable]
			)

		redirect to("/users/#{@deck.user_id}")
	end

	get '/decks/:did' do

		@user = current_user
		@deck = Deck.find(params[:did])
		@cards = Card.where(:deck_id => @deck.id)
		session[:deck_id] = @deck.id

		erb :'deck/show'
	end

	delete '/decks/:did/delete' do
		@deck = Deck.find(params[:did])
		redirect to('/') if @deck.user_id != current_user.id
		# add a check if a deck id that doesn't exist is entered directly to uri
		@deck.destroy

		redirect to("users/#{current_user.id}")
	end

	error do
		binding.pry
		redirect '/'
	end

end