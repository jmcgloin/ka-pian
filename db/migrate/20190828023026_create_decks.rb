class CreateDecks < ActiveRecord::Migration[5.2]
  def change
  	create_table :decks do |d|
  		d.string :deck_name
  		d.string :keywords
  		d.integer :shareable
  		d.integer :user_id
  	end
  end
end
