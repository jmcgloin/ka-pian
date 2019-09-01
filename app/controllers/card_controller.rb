class CardController <  ApplicationController

	get '/cards/new' do
		@user, @deck = current_info
		erb :'card/new'
	end

	post '/cards/new' do
		@user, @deck = current_info
		@card = Card.create(
			:deck_name => params[:deck_name],
			:keywords => params[:keywords],
			:shareable => params[:shareable],
			:user_id => @user.id
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
			:deck_name => params[:deck_name],
			:keywords => params[:keywords],
			:shareable => params[:shareable]
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