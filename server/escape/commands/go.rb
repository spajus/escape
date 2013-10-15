module Escape::Commands

  def self.go(context, direction)
    Go.do(context, direction)
  end

  def self.go_help
    "Go to some direction"
  end

  module Go
    module Methods

      def do(context, direction)
        char = context.char
        new_loc = Escape::Logic::Direction.offset(char.location, direction)
        if cell = Escape::Models::Cell.at(new_loc)
          if Escape::Logic::Area.movable?(cell.kind)
            char.relocate!(new_loc)
            "You are now at #{cell.desc}"
          end
        else
          "Cannot go there"
        end
      end

    end

    extend Methods
  end
end
