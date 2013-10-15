module Escape

  class Context

    def initialize(session)
      @session = session
    end

    def logged_in?
      @session[:char_id].present?
    end

    def login(char)
      @session[:char_id] = char.id
      "Welcome, #{char.name}!"
    end

    def logout
      char.seen!
      @session.delete(:char_id)
    end

    def char
      if char_id = @session[:char_id]
        Escape::Models::Char.find(char_id)
      end
    end

    private

    def set(key, val)
      @session[key] = val
    end

    def get(key)
      @session[key]
    end

    def delete(key)
      @session.delete(key)
    end

  end
end
