require 'mongo'
require 'sinatra'
require 'json'

use Rack::Logger
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
  logger.info("Adding new run: " + run.to_s)
  erb :new, :format => :json, :locals => { :run => JSON.pretty_generate(run) }
end

helpers do
  def logger
    request.logger
  end
end