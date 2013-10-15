require 'sinatra'
require 'pry-nav'
require 'json'
require 'sinatra/activerecord'
require_relative 'escape/escape'

root_dir = File.join(File.dirname(File.dirname(__FILE__)))
client_dir = File.join(root_dir, 'client')
set :public_folder, client_dir
set :database_file, File.join(root_dir, 'db', 'database.yml')

get '/' do
  send_file File.join(client_dir, 'index.html')
end

post '/command' do
  content_type :json
  Escape::Commands.run(params[:command]).to_json
end
