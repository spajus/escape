require 'sinatra'
require 'json'
require 'sinatra/activerecord'
require_relative 'escape/escape'

require 'pry-nav' if settings.development?

root_dir = File.join(File.dirname(File.dirname(__FILE__)))
client_dir = File.join(root_dir, 'client')
set :public_folder, client_dir
set :database_file, File.join(root_dir, 'db', 'database.yml')
enable :sessions
set :session_secret, Escape::Constants::SESSION_SECRET

get '/' do
  send_file File.join(client_dir, 'index.html')
end

post '/command' do
  content_type :json
  context = Escape::Context.new(request.session)
  Escape::Commands::Runner.run(params[:command], context).to_json
end
