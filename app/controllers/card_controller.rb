class CardController <  ApplicationController

	get '/cards/new' do
		@user, @deck = current_info
		erb :'card/new'
	end

	post '/cards/new' do
		@user, @deck = current_info
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
		@user, @deck = current_info
		access_forbiden?()
		redirect to('/') if @card.user_id != @user.id
		erb :'card/edit'
	end

	put '/cards/:cid/edit' do
		@card = Card.find(params[:cid])
		@user, @deck = current_info
		redirect to('/') if @card.user_id != current_user.id
		@card.update(
			:front => params[:front],
			:back => params[:back],
			:multiple_choice_or_input => params[:choice_type]
			)

		redirect to("/cards/#{@card.id}")
	end

	get '/cards/:cid' do
		@card = Card.find(params[:cid])
		@user, @deck = current_info
		erb :'card/show'
	end

	delete '/cards/:cid/delete' do
		Card.find(params[:cid]).destroy

		redirect to("users/#{params[:id]}")
	end

end