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
  property :score,      Integer   
  
end

Score.auto_migrate! unless Score.storage_exists?

helpers do
  include Rack::Utils
  alias_method :h, :escape_html
end

get '/' do
  
  erb :main
  
end

get '/high-scores' do

  score = Score.last().score
  highest = Score.all(:order => [ :score.desc ], :limit => 5)

  erb :high_scores, :locals => {:score => score, :highest => highest}

end

post '/post-score' do

  # Parameters sent from game.rb
  #puts params 

  # Save new score
  current = Score.new
  current.attributes = { :score => params[:end_score] }
  current.save
  #puts current.score

  # Note: Old code. Manually created index.html file below. Not sure what I was doing 4 years ago...
  #highest = Score.all(:order => [ :score.desc ], :limit => 5)
  
  #text = erb :high_scores, :locals => {:score => params[:score], :highest => highest}
  #path = File.join(File.dirname(__FILE__), 'public/index.html')
  #File.open( path, 'w') { |f| f.write text }
end


