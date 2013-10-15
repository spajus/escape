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

    module Methods
      def parse_type(type)
        available_types = TYPES.keys.map(&:to_s)
        if available_types.include? type
          TYPES[type.to_sym]
        else
          raise Escape::BadCommand.new(
            "Wrong area type \"#{type}\". Available types: #{available_types.join(', ')}")
        end
      end
    end

    extend Methods
  end
end
