class Board
  attr_reader :board

  # The possible combinations needed to win the game
  WINNING_LINES = [
    [0, 1, 2], [3, 4, 5], [6, 7, 8],
    [0, 3, 6], [1, 4, 7], [2, 5, 8],
    [0, 4, 8], [2, 4, 6]   
  ].freeze

  def initialize
    @board = [1, 2, 3, 4, 5, 6, 7, 8, 9]
  end

  # Display the board
  def display
    puts %Q(

       #{board[0]} | #{board[1]} | #{board[2]}
      ---+---+---
       #{board[3]} | #{board[4]} | #{board[5]}
      ---+---+---
       #{board[6]} | #{board[7]} | #{board[8]}

    )
  end
  
  # Marks the board at the specified location with the provided symbol
  def mark_board(location, symbol)
    @board[location] = symbol
  end

  # Checks if input is a single digit number between 1 and 9 and board location has not been marked
  def valid_move?(location)
    location.between?(1, 9) && board[location - 1].is_a?(Integer)
  end

  # Determines whether the board is filled with non-digit characters
  def filled?
    board.all? { |space| space =~ /\D/}
  end

  # Determines whether the game has ended
  def game_over?
    # Loop through the possible winning lines and check whether the line contains the same symbol
    WINNING_LINES.any? do |line|
      [board[line[0]], board[line[1]], board[line[2]]].uniq.length == 1
    end
  end

end