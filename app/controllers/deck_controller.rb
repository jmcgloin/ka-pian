class DeckController <  ApplicationController

	get '/users/:id/decks/new' do
		redirect to('/') if !correct_user?(params[:id])
		@user = current_user
		erb :'deck/new'
	end

	post '/users/:id/decks/new' do
		redirect to('/') if !correct_user?(params[:id])
		@user = current_user
		@deck = Deck.create(
			:deck_name => params[:deck_name],
			:keywords => params[:keywords],
			:shareable => params[:shareable],
			:user_id => @user.id
			)

		redirect to("/users/#{@user.id}") # change this to deck/add cards page
	end

	get '/users/:id/decks/:did/edit' do
		redirect to('/') if !correct_user?(params[:id])
		# add a check if a deck id that doesn't exist is entered directly to uri
		@user = current_user
		@deck = Deck.find(params[:did])
		erb :'deck/edit'
	end

	put '/users/:id/decks/:did/edit' do
		redirect to('/') if !correct_user?(params[:id])
		# add a check if a deck id that doesn't exist is entered directly to uri
		@deck = Deck.find(params[:did])
		@deck.update(
			:deck_name => params[:deck_name],
			:keywords => params[:keywords],
			:shareable => params[:shareable]
			)

		redirect to("/users/#{@deck.user_id}")
	end

	get '/users/:id/decks/:did' do
		@user = current_user
		@deck = Deck.find(params[:did])
		@cards = Card.where(:deck_id => @deck.id)

		erb :'deck/show'
	end

	delete '/users/:id/decks/:did/delete' do
		redirect to('/') if !correct_user?(params[:id])
		# add a check if a deck id that doesn't exist is entered directly to uri
		Deck.find(params[:did]).destroy

		redirect to("users/#{params[:id]}")
	end

end