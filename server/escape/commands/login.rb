module Escape::Commands

  def self.login(context, name_and_pass)
    Login.do(context, name_and_pass)
  end

  def self.login_help
    Login.help
  end

  module Login

    extend Create::SharedMethods

    class << self

      def help
        'Login to existing character with "login <name> <password>"'
      end

      def do(context, name_and_pass)
        verify(context)
        name, pass = prepare_args(name_and_pass)
        char = Char.where(name: name, pass: pass).first
        if char
          char.seen!
          context.login(char)
        else
          sleep 3
          "Nope."
        end

      end

    end
  end

end
