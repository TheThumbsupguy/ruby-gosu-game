#!/usr/bin/env ruby

require 'sinatra'
require 'gosu'
require 'net/http'
require 'uri'


## game portion ##
class GameWindow < Gosu::Window
  def initialize
    super(800, 480, false)
    self.caption = "Mah Ruby Game"

    @background_image = Gosu::Image.new(self, "media/Space.jpg", true)
    
    @player = Player.new(self)
    @player.warp(400, 300)
    
    @star_anim = Gosu::Image::load_tiles(self, "media/Star.png", 25, 25, false)
    @stars = Array.new
    
    @font = Gosu::Font.new(self, Gosu::default_font_name, 20)
    
    @last_frame = Gosu::milliseconds
  end

  def update
    calculate_delta
    
    if button_down? Gosu::Button::KbLeft or button_down? Gosu::Button::GpLeft then
      @player.turn_left
    end
    if button_down? Gosu::Button::KbRight or button_down? Gosu::Button::GpRight then
      @player.turn_right
    end
    if button_down? Gosu::Button::KbUp or button_down? Gosu::Button::GpButton0 then
      @player.accelerate
    end
    @player.move
    @player.collect_stars(@stars)
    
    if rand(100) < 4 and @stars.size < 25 then
      @stars.push(Star.new(@star_anim))
    end
    
    ### START TIMER CODE ###
    
    if @timer == 30.0 then
      
      @end_score = @player.score
      url = URI.parse('http://127.0.0.1:4567/scorePage')
      params =  {'score' => @end_score}
      res = Net::HTTP.post_form(url, params)
      #puts res.body
      
      

      
      close() #closes game
      
    end
    
    ### END TIMER CODE ###
    
  end

  def draw
    @background_image.draw(0, 0, ZOrder::Background)
    @player.draw
    @stars.each { |star| star.draw }
    @font.draw("Score: #{@player.score}", 675, 30, ZOrder::UI, 1.0, 1.0, 0xffffff00)
    @font.draw("Timer: #{@timer}", 675, 10, ZOrder::UI, 1.0, 1.0, 0xffffff00)
    
  end
  
  def button_down(id)
    if id == Gosu::Button::KbEscape
      close
    end
  end
  
  def calculate_delta
    @this_frame = Gosu::milliseconds
    @delta = @this_frame - @last_frame
    @last_frame = @this_frame
    @timer = (@last_frame / 1000.0).round(1)
  end
end

class Player
  attr_reader :score
  
  def initialize(window)
    @image = Gosu::Image.new(window, "media/Starfighter.png", false)
    @beep = Gosu::Sample.new(window, "media/Beep.wav")
    @x = @y = @vel_x = @vel_y = @angle = 0.0
    @score = 0
  end

  def warp(x, y)
    @x, @y = x, y
  end
  
  def turn_left
    @angle -= 4.5
  end
  
  def turn_right
    @angle += 4.5
  end
  
  def accelerate
    @vel_x += Gosu::offset_x(@angle, 0.5)
    @vel_y += Gosu::offset_y(@angle, 0.5)
  end
  
  def move
    @x += @vel_x
    @y += @vel_y
    @x %= 640
    @y %= 480
    
    @vel_x *= 0.95
    @vel_y *= 0.95
  end

  def draw
    @image.draw_rot(@x, @y, 1, @angle)
  end
  
  def collect_stars(stars)
    stars.reject! do |star|
      if Gosu::distance(@x, @y, star.x, star.y) < 35 then
        @score += 10
        @beep.play
        true
      else
        false
      end
    end
  end
end

module ZOrder
  Background, Stars, Player, UI = *0..3
end

class Star
  attr_reader :x, :y
  
  def initialize(animation)
    @animation = animation
    @color = Gosu::Color.new(0xff000000)
    @color.red = rand(255 - 40) + 40
    @color.green = rand(255 - 40) + 40
    @color.blue = rand(255 - 40) + 40
    @x = rand * 640
    @y = rand * 480
  end

  def draw  
    img = @animation[Gosu::milliseconds / 100 % @animation.size];
    img.draw(@x - img.width / 2.0, @y - img.height / 2.0,
        ZOrder::Stars, 1, 1, @color, :additive)
  end
end

window = GameWindow.new
window.show