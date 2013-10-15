module Escape

  class Context

    def initialize(session)
      @session = session
    end

    def char
      if char_id = @session[:char_id]
        Char.find(char_id)
      end
    end

    def set(key, val)
      @session[key] = val
    end

    def get(key)
      @session[key]
    end

  end
end
