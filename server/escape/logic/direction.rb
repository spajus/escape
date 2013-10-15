module Escape::Logic
  module Direction

    LIST = [:n, :s, :e, :w, :u, :d]
    REVERSE_MAP = { n: :s,
                    s: :n,
                    e: :w,
                    w: :e,
                    u: :d,
                    d: :u, }

              #dir: x,  y,  z
    SHIFTS = { n: [ 0, -1,  0 ],
               s: [ 0,  1,  0 ],
               e: [ 1,  0,  0 ],
               w: [-1,  0,  0 ],
               u: [ 0,  0,  1 ],
               d: [ 0,  0, -1 ] }

    module Methods
      def offset(location, direction)
        location.zip(SHIFTS[parse(direction)]).map { |v| v.inject(:+) }
      end

      private

      def parse(direction)
        parsed = direction.downcase[0]
        if 'nsweud'.include? parsed
          parsed.to_sym
        else
          raise BadCommand("Wrong direction: #{direction}. Try n, s, e, w, u, d.")
        end
      end
    end

    extend Methods

  end
end
