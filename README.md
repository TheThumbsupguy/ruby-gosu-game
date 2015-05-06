# Ruby Game

An Asteroids style shooter.

## Controls

Use arrow keys to move.

## Objective

You have 30 seconds to collect as many items as possible.

After 30 seconds, the game will stop and post the score.

## Install and Play

You'll need <a href="http://rubyinstaller.org/downloads/">Ruby</a> and <a href="https://github.com/oneclick/rubyinstaller/wiki/Development-Kit">Development Kit</a> installed.

Dependencies: `gem install sinatra`, `gem install gosu`, `gem install data_mapper`, `gem install dm-sqlite-adapter`.

Navigate to the game's directory in a terminal window.

Run `ruby scorePage.rb` to setup the local webserver.

In another terminal window run, `ruby game.rb` to play the game. 

The scores are viewable at http://127.0.0.1:4567/scorePage.
