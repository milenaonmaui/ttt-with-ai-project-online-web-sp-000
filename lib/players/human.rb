class Players::Human < Player
  def move(board)
    board.display
    puts "Enter position, player #{self.token}:"
    gets.strip
  end
end
