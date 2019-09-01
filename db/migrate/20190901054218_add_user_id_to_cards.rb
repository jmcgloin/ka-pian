class AddUserIdToCards < ActiveRecord::Migration[5.2]
  def change
  	change_table :cards do |d|
  		d.integer :user_id
  	end
  end
end
