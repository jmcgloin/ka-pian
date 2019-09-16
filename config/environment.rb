require 'bundler'
Bundler.require

require 'sinatra/flash'

configure do
	mime_type :javascript, 'text/javascript'
	mime_type :css, 'text/css'
end

require_all 'app'
require_all 'public'