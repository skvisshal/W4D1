require_relative 'tic_tac_toe_node'

class SuperComputerPlayer < ComputerPlayer
  def move(game, mark)
    node = TicTacToeNode.new(game.board,mark)
    p game.board
    children = node.children
    children.each do  |child|
          child.print_board 
         if child.winning_node?(mark)
            return child.prev_move_pos
         end 
    end
    children.each do  |child| 
         if !child.losing_node?(mark)
            return child.prev_move_pos
         end 
    end
    raise "No none losing nodes"
  end
end

if __FILE__ == $PROGRAM_NAME
  puts "Play the brilliant computer!"
  hp = HumanPlayer.new("Jeff")
  cp = SuperComputerPlayer.new

  TicTacToe.new(hp, cp).run
end
