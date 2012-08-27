require 'mongo'
require 'sinatra'

@@conn = Mongo::Connection.new
@@db   = @@conn['toc']

get '/productionline/runs' do
  "List of runs"

  runs = @@db['runs']

  runs.to_s
  # @@runs.each_with_index do |run, index|
  #   output << @@runs['number_of_stations']
  #   output << @@runs['initial_inventory_size']
  # end
  # @@runs.count.to_s

  # output
  erb :index, :format => :html, :locals => { :runs => runs }
end

post '/productionline/run' do
  201
end
