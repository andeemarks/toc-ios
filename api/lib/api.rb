require 'mongo'
require 'sinatra'
require 'json'

@@conn = Mongo::Connection.new
@@db   = @@conn['toc']

get '/productionline/runs' do
  runs = @@db['runs']

  erb :index, :format => :html, :locals => { :runs => runs }
end

post '/productionline/run' do
  request.body.rewind
  run = JSON.parse request.body.read

  runs = @@db['runs']
  runs.insert(run) if run

  status 201
  content_type 'application/json'
  erb :new, :format => :json, :locals => { :run => run }
end
