# Ruby Game

An Asteroids style shooter.

## Controls

Use arrow keys to move.

## Objective

You have 30 seconds to collect as many items as possible.

After 30 seconds, the game will stop and post the score.

## Install and Play

You'll need <a href="http://rubyinstaller.org/downloads/" target="_blank">Ruby</a> and <a href="https://github.com/oneclick/rubyinstaller/wiki/Development-Kit" target="_blank">Development Kit</a> installed.

Run the following commands to install the required dependencies: `gem install sinatra`, `gem install gosu`, `gem install data_mapper`, `gem install dm-sqlite-adapter`.

Also, you may need to go to <a href="http://sqlite.org/download.html" target="_blank">sqlite.org</a> and download "Precompiled Binaries" of sqlite. For Windows, get sqlite-shell-win32-x86-3080900.zip and sqlite-dll-win32-x86-3080900.zip. Once downloaded, extract their contents to your `bin` directory where Ruby is installed. This fixed my sqlite3 Load Error on Windows.

Navigate to the game's directory in a terminal window.

Run `ruby scorePage.rb` to setup the local webserver.

In another terminal window run, `ruby game.rb` to play the game. 

The scores are viewable at <a href="http://127.0.0.1:4567/scorePage" target="_blank">127.0.0.1:4567/scorePage</a>.
