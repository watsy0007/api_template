require 'sinatra'
require 'sinatra/reloader'
require 'json'

def data(file_name)
  JSON.parse(File.open('./data/' + file_name + '.json').read)
end

def json(data = {}, code = 200)
  status code
  data.to_json
end

users = data('users')

get '/users' do
  json users
end

get '/users/:id' do
  user = users.find do |item|
    item['id'] == params['id'].to_i
  end
  json user
end

post '/users' do
  user = {}
  user['id'] = users.empty? ? 1 : (users.last['id'] + 1)
  user['name'] = params['name']
  users << user
  json user, 201
end

delete '/users/:id' do
  users = users.delete_if do |item|
    item['id'] == params['id'].to_i
  end
  json user.empty? ? {} : users.first
end
