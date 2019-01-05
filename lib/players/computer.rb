class Players::Computer < Player

  def move(board)
    #(board.cells.index(" ") + 1).to_s
    self.game.next_move(self.token)
  end
end
