require_relative 'pieces'

class Board
    attr_reader :rows
    
    
    
    def initialize(fill_board = true)
       @sentinel = NullPiece.instance
        make_starting_grid(fill_board)
    end
    
    def pieces
        @rows.flatten.reject(&:empty)
    end
    
    private
    
    attr_reader :sentinel

    def find_king(color)
        king_pos = pieces.find { |p| p.color == color && p.is_a?(King) }
        king_pos || (raise 'king not found')
    end

    
    def fill_back_row(color)
       back_pieces = [Rook, Knight, Bishop, Queen, King, Bishop, Knight, Rook] 
       i = color == "white" ? 7: 0
       back_pieces.each_with_index do |piece_class, j| 
           piece_class.new(color, self, [i,j])
       end
    end
    
    def fill_pawns_row(color)
        i = color == "white" ? 6: 1
        8.times { |j| Pawn.new(color, self, [i,j]) }
     
    end
    
    def make_starting_grid(fill_board)
       # make grid
       @rows = Array.new(8) { Array.new(8, sentinel) }
       return unless fill_board
       %i(white black).each do |color|
           fill_back_row(color)
           fill_pawns_row(color)
        end
       
       
       
    end
end