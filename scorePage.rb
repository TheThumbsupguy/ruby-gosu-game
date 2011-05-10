#!/usr/bin/env ruby

require 'sinatra'
require "json"

get '/' do
  erb :main
end

get '/example.json' do
  content_type :json
  { :key1 => 'value1', :key2 => 'value2' }.to_json
end