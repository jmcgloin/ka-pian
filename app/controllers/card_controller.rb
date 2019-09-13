class CardController <  ApplicationController

	get '/cards/new' do
		@user = access_forbiden?(current_user.id)
		@deck = current_deck

		erb :'card/new'
	end

	post '/cards/new' do
		@user = access_forbiden?(current_user.id)
		@deck = current_deck
		@card = Card.create(
			:front => params[:front],
			:back => params[:back],
			:multiple_choice_or_input => params[:choice_type],
			:user_id => @user.id,
			:deck_id => @deck.id,
			:frequency => 1
			)

		redirect to("/cards/#{@card.id}")
	end

	get '/cards/:cid/edit' do
		@card = Card.find(params[:cid])
		@user = access_forbiden?(@card.user_id)
		@deck = current_deck
		
		erb :'card/edit'
	end

	put '/cards/:cid/edit' do
		@card = Card.find(params[:cid])
		@user = access_forbiden?(@card.user_id)
		@deck = current_deck
		@card.update(
			:front => params[:front],
			:back => params[:back],
			:multiple_choice_or_input => params[:choice_type]
			)

		redirect to("/cards/#{@card.id}")
	end

	get '/cards/:cid' do
		@card = Card.find(params[:cid])
		@user = access_forbiden?(@card.user_id)
		@deck = current_deck
		erb :'card/show'
	end

	delete '/cards/:cid/delete' do
		@card = Card.find(params[:cid])
		@user = access_forbiden?(@card.user_id)
		@deck = current_deck
		@card.destroy
		redirect to("/decks/#{@deck.id}")
	end

end