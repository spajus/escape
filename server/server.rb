require 'sinatra'
require 'pry-nav'
require 'json'
require_relative 'escape/escape'

client_dir = File.join(File.dirname(__FILE__), '..', 'client')
set :public_folder, client_dir

get '/' do
  send_file File.join(client_dir, 'index.html')
end

post '/command' do
  content_type :json
  Escape::Commands.run(params[:command]).to_json
end
