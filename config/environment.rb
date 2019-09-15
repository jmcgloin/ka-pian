require 'bundler'
Bundler.require

require 'sinatra/flash'

configure :development do
	set :database, {adapter: "sqlite3", database: "db/database.sqlite3"}
end

require_all 'app'
require_all 'public'