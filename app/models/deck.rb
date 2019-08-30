class Deck < ActiveRecord::Base
	validates :deck_name, length: { minimum: 1 }, uniqueness: true
	has_many :cards
	belongs_to :user
end