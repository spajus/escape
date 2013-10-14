require 'sinatra'

client_dir = File.join(File.dirname(__FILE__), '..', 'client')
set :public_folder, client_dir

get '/' do
  send_file File.join(client_dir, 'index.html')
end
