require_relative 'tic_tac_toe'
require 'byebug'
class TicTacToeNode

  attr_reader :board, :next_mover_mark, :prev_move_pos

  def initialize(board, next_mover_mark, prev_move_pos = nil)
    @board = board
    @next_mover_mark = next_mover_mark
    @prev_move_pos = prev_move_pos
  end

  def losing_node?(evaluator)
    if board.over?
      return @board.won? && @board.winner != evaluator
    end
    children = self.children
    if evaluator == @next_mover_mark
      return true if children.all? {|child|child.losing_node?(evaluator)} 
    else
      return true if children.any? {|child|child.losing_node?(evaluator)}
    end
    false
  end

  def winning_node?(evaluator)
  end

  # This method generates an array of all moves that can be made after
  # the current move.
  def children
    nodes = []
    (0...@board.rows.length).each do |i|
      (0...@board.rows[i].length).each do |j|
        pos = [i,j]
        if @board.empty?(pos)
          new_board = @board.dup
          new_board[[i,j]] = @next_mover_mark
          alt_mark = (@next_mover_mark == :x ? :o : :x)
          nodes << TicTacToeNode.new(new_board, alt_mark, pos)
        end
      end
    end
    nodes
  end

  def print_board
    (0...@board.rows.length).each do |i|
      (0...@board.rows[i].length).each do |j|
        print @board[[i,j]]
      end
      puts 
    end
    puts
  end
end
