class AddDeckIdToCard < ActiveRecord::Migration[5.2]
  def change
  	change_table :cards do |d|
  		d.integer :deck_id
  	end
  end
end
