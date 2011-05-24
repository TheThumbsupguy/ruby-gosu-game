#!/usr/bin/env ruby

require 'sinatra'
require 'net/http'
require 'uri'

helpers do
  include Rack::Utils
  alias_method :h, :escape_html
end

get '/' do
  erb :main
end

post '/scorePage' do
  text = erb :scorePage, :locals => {:score => params[:score]}
  path = File.join(File.dirname(__FILE__), 'public/index.html')
  File.open( path, 'w') { |f| f.write text }
end
