class CardController <  ApplicationController


	attr_accessor :user, :deck, :card

	get '/cards/new' do
		helper

		erb :'card/new'
	end

	get '/cards/notfound' do
		@deck = current_deck
		
		erb :'card/notfound'
	end

	post '/cards' do
		helper
		@card = Card.create(
			:front => params[:front],
			:back => params[:back],
			:multiple_choice_or_input => params[:choice_type],
			:user_id => @user.id,
			:deck_id => @deck.id,
			:frequency => 1
			)
		@deck.update(:card_count => @deck.card_count + 1)
		
		redirect to("/cards/#{@card.id}")
	end

	get '/cards/:cid/edit' do
		helper(params[:cid])
		
		erb :'card/edit'
	end

	put '/cards/:cid' do
		helper(params[:cid])
		@card.update(
			:front => params[:front],
			:back => params[:back],
			:multiple_choice_or_input => params[:choice_type]
			)

		redirect to("/cards/#{@card.id}")
	end

	get '/cards/:cid' do
		helper(params[:cid])
		
		erb :'card/show'

	end

	delete '/cards/:cid' do
		helper(params[:cid])
		@card.destroy
		@deck.update(:card_count => @deck.card_count - 1)

		redirect to("/decks/#{@deck.id}")
	end

	def helper(cid = nil)
		caller_line = caller_locations.first.to_s.match(/\d+/)[0].to_i
		@card = Card.find_by_id(cid)
		@user = !!@card ? User.find_by_id(@card.user_id) : current_user
		@deck = !!@card ? Deck.find_by_id(@card.deck_id) : current_deck
		access_forbiden?(@user.id)

		redirect to('/cards/notfound') if (!@card && caller_line > 31)
		
	end

	# get '/*' do
	# 	erb :not_found
	# end

end