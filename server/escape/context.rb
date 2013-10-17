module Escape

  class Context

    BACK_WINDOW = 3.minutes

    def initialize(session, params)
      @session = session
      @params = params
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

    def since
      return @since if @since
      back_ago = BACK_WINDOW.ago.to_i
      since = @params[:since].to_i || back_ago
      since = back_ago if since < back_ago
      @since = Time.at(since)
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
