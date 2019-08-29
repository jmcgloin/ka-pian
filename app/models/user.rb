class User < ActiveRecord::Base
	validates :username, length: { minimum: 1 }, uniqueness: true
	has_secure_password
	has_many :decks
end