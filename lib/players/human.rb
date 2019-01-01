class Players::Human < Player
  def move(board)
    puts "Enter position"
    gets.strip
  end
end
