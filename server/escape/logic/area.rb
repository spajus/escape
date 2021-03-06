module Escape::Logic
  module Area

    TYPES = {
      wall:       0,
      room:       1,
      forest:     2,
      desert:     3,
      lake:       4,
      river:      5,
      hill:       6,
      meadow:     7,
      chamber:    8,
    }


    UNMOVABLE = [:wall, :lake, :river].map { |t| TYPES[t] }

    module Methods

      def movable?(type)
        !UNMOVABLE.include?(type)
      end

      def parse_type(type)
        available_types = TYPES.keys.map(&:to_s)
        if available_types.include? type
          TYPES[type.to_sym]
        else
          raise Escape::BadCommand.new(
            "Wrong area type \"#{type}\". Available types: #{available_types.join(', ')}")
        end
      end



      def chunk(location)
        off_x = Escape::Constants::GRID_WIDTH  / 2
        off_y = Escape::Constants::GRID_HEIGHT / 2
        x, y, z = location
        cells = Escape::Models::Cell.where("x in (?) and y in (?) and z = ?",
                                           (x - off_x .. x + off_x),
                                           (y - off_y .. y + off_y),
                                           z)
        chars = Escape::Models::Char.where("x in (?) and y in (?) and z = ?",
                                           (x - off_x .. x + off_x),
                                           (y - off_y .. y + off_y),
                                           z)
        cell_map = {}
        cells.map do |cell|
          cell_hash = "#{cell.x}:#{cell.y}"
          cell_map[cell_hash] = cell
        end

        char_map = {}
        chars.map do |char|
          char_hash = "#{char.x}:#{char.y}"
          char_map[char_hash] = char
        end

        grid = []
        (0..Escape::Constants::GRID_HEIGHT).each do |grid_y|
          grid_row = []
          (0..Escape::Constants::GRID_WIDTH).each do |grid_x|

            grid_loc_x = x + grid_x - off_x
            grid_loc_y = y + grid_y - off_y
            grid_hash = "#{grid_loc_x}:#{grid_loc_y}"
            cell = cell_map[grid_hash]
            if cell
              grid_row << [cell.kind, char_map[grid_hash].try(:name)]
            else
              grid_row << nil
            end
          end
          grid << grid_row
        end
        grid
      end
    end

    extend Methods
  end
end
