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
     @player_1.game = self
     @player_2.game = self

   end
   def turn_count(player)
     @board.cells.count{|square| square == player.token }
   end

   def current_player
     turn_count(@player_1) <= turn_count(@player_2)? player_1 : player_2
   end

   def won?
     WIN_COMBINATIONS.any? do |combo|
      if @board.taken?(combo[0]+1) && @board.cells[combo[0]] == @board.cells[combo[1]] && @board.cells[combo[1]] == @board.cells[combo[2]]
        return combo
      elsif
        !@board.full? #draw
      end
    end
   end

   def draw?
     @board.full? && !won?
   end

   def over?
      won? || draw?
   end

   def winner
      if combo = won?
        @board.cells[combo[0]]
      else
        return nil
      end
   end

   def next_move(token)
     oponent = (token == "X" ? "O" : "X")
     return winning_spot(token) if winning_spot(token)
      #prevent oponent from winning
     return winning_spot(oponent) if winning_spot(oponent)
     if @board.cells[4] == " "
       return "5"
     end
     find_good_move(token)
   end

  def find_good_move(token)
  # if no winning spots, eliminate all combos that already have oponent
    oponent = (token == "X" ? "O" : "X")
    arr_oponent = count_token(oponent)
    arr_player = count_token(token)
    combo = nil
    for i in 0..8 do
      if arr_oponent[i] == 0 && arr_player[i] == 1
        combo = WIN_COMBINATIONS[i]
        break
      end
    end
    if combo
      arr = [@board.cells[combo[0]], @board.cells[combo[1]], @board.cells[combo[2]]]
      return (combo[arr.find_index(" ")] + 1).to_s
    else
      return (board.cells.index(" ") + 1).to_s
    end
  end

   #count number of tkens in each combo
   def count_token(token)
     WIN_COMBINATIONS.map do |combo|
      arr = [@board.cells[combo[0]], @board.cells[combo[1]], @board.cells[combo[2]]]
      arr.count(token)
     end
   end

   def winning_spot(token)
     #find if there is a combo with two tokens of same kind and the third place empty
     WIN_COMBINATIONS.each do |combo|
       arr = [@board.cells[combo[0]], @board.cells[combo[1]], @board.cells[combo[2]]]
       if arr.count(token)==2 && arr.count(" ")==1
         return (combo[arr.find_index(" ")] + 1).to_s
       end
    end
      return nil
   end

   def turn
     user_input = current_player.move(@board)
     if @board.valid_move?(user_input)
        @board.update(user_input, current_player)
     else
        turn
      end
   end

   def play
    turn until over?
    @board.display
    puts winner ? "Congratulations #{winner}!" : "Cat's Game!"
   end
end #class
