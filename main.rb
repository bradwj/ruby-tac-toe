require_relative 'lib/game'

def start_game
  game = Game.new
  game.start
  loop_game
end

def loop_game
  print "Would you like to play again? [Y/N]: "
  start_game if gets.chomp.downcase == 'y'

  puts "Thanks for playing Ruby-Tac-Toe!"
end

start_game