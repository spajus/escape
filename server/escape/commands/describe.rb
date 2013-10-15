module Escape::Commands

  def self.describe(context, args)
    Describe.do(context, args)
  end

  def self.describe_help
    Describe.help
  end

  module Describe
    class << self
      def do(context, args)
        direction, type, description = parse(args)
        loc = context.char.location
        loc = Escape::Logic::Direction.offset(loc, direction)
        if Escape::Models::Cell.exists_at?(loc)
          "There is something already in that direction"
        else
          cell = Escape::Models::Cell.describe(location: loc,
                                               kind: type,
                                               desc: description,
                                               creator: context.char)
          if cell.valid? && cell.save
            "You've just created a piece of this universe"
          else
            errors = char.errors.map { |f, e| "#{f} #{e}" }
            "Cannot describe location: #{errors.join(", ")}"
          end
        end
      end

      def help
        'Describe map with "describe <direction> <type> [description]"'
      end

      private

      def parse(args)
        raise Escape::BadCommand.new(help) if args.nil?
        direction, type, description = args.split(' ', 3)
        type = Escape::Logic::Area.parse_type(type)
        [direction, type, description]
      end
    end
  end
end
