require_relative 'board'
require_relative 'player'

class Game
  attr_reader :player_1, :player_2, :board, :current_player

  def initialize
    @board = Board.new()
    @player_1, @player_2, @current_player = nil
  end
  
  # Begin the game
  def start
    puts "\n\n\n\nWelcome to Ruby-Tac-Toe!"
    setup
    board.display
    cycle_turns
    end_game
  end

  private
  
  # Allow the two players to take turns
  def cycle_turns
    @current_player = player_1
    until board.filled?
      print "Your turn, #{current_player.name} (#{current_player.symbol}). "
      player_turn(current_player)
      break if board.game_over?
      
      @current_player = switch_current_player
    end
  end

  # Marks the board according to the player input
  def player_turn(player)
    input = turn_input(player)
    board.mark_board(input - 1, player.symbol)
    board.display
  end
  
  # Get player input to mark board depending if the player is a computer or human player
  def turn_input(player)
    player.is_a?(Computer) ? computer_input : player_input
  end

  # Get input from player to mark the board
  def player_input
    print "Choose a number to mark the board: "
    input = gets.chomp.to_i
    return input if board.valid_move?(input)

    puts "That is not a valid input. Try again."
    player_input
  end

  # Get input from computer to mark the board
  def computer_input
    input = 1 + rand(9)
    return input if board.valid_move?(input)
    computer_input
  end

  # Create the player objects
  def setup
    if play_against_computer?
      print "Enter your name: "
      player_name = gets.chomp
      player_symbol = symbol_input

      @player_1 = Player.new(player_name, player_symbol)
      @player_2 = Computer.new(player_symbol)
    else
      print "Enter name of player 1: "
      player1_name = gets.chomp
      player1_symbol = symbol_input
      
      print "Enter name of player 2: "
      player2_name = name_input(player1_name)
      player2_symbol = symbol_input(player1_symbol)
      
      @player_1 = Player.new(player1_name, player1_symbol)
      @player_2 = Player.new(player2_name, player2_symbol)
    end
  end

  # Get the name input for a player
  def name_input(name_taken = nil)
    input = gets.chomp
    return input unless input == name_taken

    print "Players cannot have the same name. Try entering a different name: "
    name_input(name_taken)
  end

  # Get the symbol input for a player
  def symbol_input(symbol_taken = nil)
    print "Enter a symbol to use (eg. 'X' or 'O'): "
    input = gets.chomp
    return input if valid_symbol?(input) && input != symbol_taken

    puts "Players cannot use the same symbol." if input == symbol_taken
    puts "That symbol is not valid. Symbols cannot be a number and must only be one character in length."
    symbol_input(symbol_taken)
  end

  # Display the outcome of the game
  def end_game
    if board.game_over?
      puts "#{@current_player.name} WINS! Congratulations."
    else
      puts "Well, that was anticlimactic. Players tied."
    end
  end

  # Determines whether an inputted symbol is valid
  def valid_symbol?(symbol)
    symbol.length == 1 && symbol.match?(/\D/)
  end

  # Used to determine if the user wants to play against a computer
  def play_against_computer?
    print "Would you like to play against a computer? [Y/N]: "
    gets.chomp.downcase == "y"
  end

  # Switch the current player
  def switch_current_player
    current_player == player_1 ? player_2 : player_1
  end
end