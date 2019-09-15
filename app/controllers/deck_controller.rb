class DeckController <  ApplicationController


	attr_accessor :user, :deck, :cards

	get '/decks/new' do
		helper

		erb :'deck/new'
	end

	post '/decks' do
		helper
		@deck = Deck.create(
			:deck_name => params[:deck_name],
			:keywords => params[:keywords],
			:shareable => params[:selection],
			:user_id => @user.id,
			:card_count => 0
			)
		session[:deck_id] = @deck.id

		redirect to("/users/#{@user.id}")
	end

	get '/decks/cards'  do
		helper
		@cards.shuffle!.to_json
	end

	get '/decks/notfound' do
		@user = current_user
		
		erb :'deck/notfound'
	end

	get '/decks/:did/edit' do
		helper(params[:did])
		@shareable = @deck.shareable ? "checked" : nil
		
		erb :'deck/edit'
	end

	put '/decks/:did' do
		helper(params[:did])
		@shareable = params[:shareable]
		@deck.update(
			:deck_name => params[:deck_name],
			:keywords => params[:keywords],
			:shareable => @shareable
			)

		redirect to("/users/#{@deck.user_id}")
	end

	get '/decks/:did' do
		helper(params[:did])

		erb :'deck/show'
	end

	get '/decks/:did/study' do
		helper(params[:did])

		erb :'deck/study'
	end

	get '/decks/:did/done' do
		helper(params[:did])

		erb :'deck/done'
	end

	delete '/decks/:did' do
		helper(params[:did])
		session[:deck_id] = nil
		@deck.destroy
		

		redirect to("users/#{current_user.id}")
	end

	def helper(did = nil)
		caller_line = caller_locations.first.to_s.match(/\d+/)[0].to_i
		@deck = Deck.find_by_id(did)
		@user = !!@deck ? User.find_by_id(@deck.user_id) : current_user
		@cards = @deck && Card.where(:deck_id => @deck.id)
		session[:deck_id] = @deck && @deck.id
		access_forbiden?(@user.id)

		redirect to('/decks/notfound') if (!@deck && caller_line > 31)
	end

end