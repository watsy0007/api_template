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
