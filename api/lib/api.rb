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
  runs = @@db['runs']
  request.body.rewind

  run = JSON.parse request.body.read
  logger.info("New run to insert: " + run.to_s)
  puts("New run to insert: " + run.to_s)

  runs.insert(run) if run

  erb :new, :format => :json, :locals => { :run => run }
end
