class Deck < ActiveRecord::Base
	validates :deck_name, length: { minimum: 1 }, uniqueness: { scope: :user_id, message: "You already have a deck with that name."}
	has_many :cards
	belongs_to :user
end