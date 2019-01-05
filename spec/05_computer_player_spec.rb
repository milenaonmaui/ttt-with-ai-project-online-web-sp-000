require 'spec_helper'

describe 'Players::Computer' do
  it 'inherits from Player' do
    expect(Players::Computer.ancestors).to include(Player)
  end

  describe '#move' do
    it 'returns a valid position for the computer to move' do
      #computer = Players::Computer.new("X")
      game = Game.new(Players::Computer.new("X"),Players::Computer.new("O"))
      #board = Board.new

      valid_moves = ["1", "2", "3", "4", "5", "6", "7", "8", "9"]

      computer_move = game.player_1.move(board)

      expect(valid_moves).to include(computer_move)
    end
  end
end
