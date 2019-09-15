class AddCardCountToDeck < ActiveRecord::Migration[5.2]
  def change
  	change_table :decks do |d|
  		d.integer :card_count
  	end
  end
end
