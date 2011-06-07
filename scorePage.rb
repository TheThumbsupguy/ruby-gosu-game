#!/usr/bin/env ruby

require 'sinatra'
require 'net/http'
require 'uri'
require 'rubygems'
require 'data_mapper'

DataMapper::setup(:default, "sqlite3://#{Dir.pwd}/score.db")

class Score
  include DataMapper::Resource

  property :id,         Serial    # An auto-increment integer key
  property :score,      String    # A varchar type string, for short strings
  
end

Score.auto_migrate! unless Score.storage_exists?

helpers do
  include Rack::Utils
  alias_method :h, :escape_html
end

get '/' do
  
  erb :main
  
end

post '/scorePage' do
  #current = Score.new
  #current.attributes = { :score => params[:score] }
  #current.save
  #puts current.inspect
  latest = Score.all(:order => [ :id.desc ], :limit => 2)
  puts latest.inspect
  
  
  
  text = erb :scorePage, :locals => {:score => params[:score], :latest => latest}
  path = File.join(File.dirname(__FILE__), 'public/index.html')
  File.open( path, 'w') { |f| f.write text }
end


