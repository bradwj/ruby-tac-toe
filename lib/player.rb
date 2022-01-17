class Player
  attr_reader :name, :symbol

  def initialize(name, symbol)
    @name = name
    @symbol = symbol
  end
end

class Computer < Player
  
  def initialize(player_symbol)
    super("Ruby-Bot", generate_symbol(player_symbol))
  end

  private

  # Generates a random symbol from a predifined list for the computer to use.
  def generate_symbol(player_symbol)
    symbol_list = 'XO!@#$%&?*+-='.split('')
    symbol_list.delete(player_symbol)
    symbol_list.sample
  end

  
end