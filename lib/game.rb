class Game
  attr_accessor :board, :player_1, :player_2
  WIN_COMBINATIONS = [
     [0, 1, 2], [3, 4, 5], [6, 7, 8],
     [0, 3, 6], [1, 4, 7], [2, 5, 8],
     [0, 4, 8], [2, 4, 6]
   ]

   def initialize(player_1 = Players::Human.new("X"),
                  player_2 = Players::Human.new("O"),
                  board=Board.new)

     @player_1 = player_1
     @player_2 = player_2
     @board = board

   end
   def turn_count(player)
     @board.cells.count{|square| square != player.token }
   end

   def current_player
     turn_count(@player_1) <= turn_count(@player_2)? player_1 : player_2
   end

   def won?
     WIN_COMBINATIONS.any? do |combo|
      if position_taken?(combo[0]) && @board[combo[0]] == @board[combo[1]] && @board[combo[1]] == @board[combo[2]]
        return combo
      end
    end
   end
end
