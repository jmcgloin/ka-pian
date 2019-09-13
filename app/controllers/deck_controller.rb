class DeckController <  ApplicationController

	get '/decks/new' do
		@user = access_forbiden?(current_user.id)
		erb :'deck/new'
	end

	post '/decks/new' do
		@user = access_forbiden?(current_user.id)
		@deck = Deck.create(
			:deck_name => params[:deck_name],
			:keywords => params[:keywords],
			:shareable => params[:selection],
			:user_id => @user.id
			)
		session[:deck_id] = @deck.id
		redirect to("/users/#{@user.id}") # change this to deck/add cards page
	end

	get '/decks/cards'  do
		@deck = current_deck
		@cards = Card.where(:deck_id => @deck.id).shuffle
		@cards.to_json
	end

	get '/decks/:did/edit' do
		@deck = Deck.find(params[:did])
		@user = access_forbiden?(@deck.user_id)
		session[:deck_id] = @deck.id
		@shareable = @deck.shareable ? "checked" : nil
		erb :'deck/edit'
	end

	put '/decks/:did/edit' do
		@deck = Deck.find(params[:did])
		@user = access_forbiden?(@deck.user_id)
		session[:deck_id] = @deck.id
		@shareable = params[:shareable]
		@deck.update(
			:deck_name => params[:deck_name],
			:keywords => params[:keywords],
			:shareable => @shareable
			)

		redirect to("/users/#{@deck.user_id}")
	end

	get '/decks/:did' do
		@deck = Deck.find(params[:did])
		@user = access_forbiden?(@deck.user_id)
		session[:deck_id] = @deck.id
		@cards = Card.where(:deck_id => @deck.id)
		erb :'deck/show'
	end

	get '/decks/:did/study' do
		@deck = Deck.find(params[:did])
		@user = access_forbiden?(@deck.user_id)
		session[:deck_id] = @deck.id
		@cards = Card.where(:deck_id => @deck.id).shuffle
		erb :'deck/study'
	end

	delete '/decks/:did/delete' do
		@deck = Deck.find(params[:did])
		@user = access_forbiden?(@deck.user_id)
		session[:deck_id] = nil
		@deck.destroy

		redirect to("users/#{current_user.id}")
	end

	# error do
	# 	binding.pry
	# 	redirect '/'
	# end

end