#!/usr/bin/env ruby

require 'sinatra'

get '/' do
  erb :main
end

def select_random my_list
  if my_list.empty?
    return nil
  end
  my_list[rand(my_list.length)]
end

post '/' do
  courses = ['pancakes', 'waffles', 'chorizo']
  toppings = ['syrup', 'fruit', 'powdered sugar']
  sides = ['hash browns', 'eggs', 'grapefruit']
  
  mc = select_random courses
  top = select_random toppings
  side = select_random sides
  erb :game, :locals => { :mc => mc, :top => top, :side => side }
end
