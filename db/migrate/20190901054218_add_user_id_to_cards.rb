class AddUserIdToCards < ActiveRecord::Migration[5.2]
  def change
  	change_table :cards do |c|
  		c.integer :user_id
  	end
  end
end
