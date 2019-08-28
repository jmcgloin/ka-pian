class CreateCards < ActiveRecord::Migration[5.2]
  def change
  	create_table :cards do |c|
  		c.string :front
  		c.string :back
  		c.integer :frequency
  		c.string :multiple_choice_or_input
  	end
  end
end
