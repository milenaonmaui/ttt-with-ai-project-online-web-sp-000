class Board
  attr_accessor :cells

  def initialize
    @cells = Array.new(9, " ")
  end

  def display
    puts " #{@cells[0]} | #{@cells[1]} | #{@cells[2]} "
    puts "-----------"
    puts " #{@cells[3]} | #{@cells[4]} | #{@cells[5]} "
    puts "-----------"
    puts " #{@cells[6]} | #{@cells[7]} | #{@cells[8]} "
  end

  def position(num)
    num = num.to_i
    @cells[num-1] unless num<1 || num >9
  end

  def full?
    @cells.include?(" ") == false
  end
  def reset!
    self.cells = [" "]*9
  end
end
