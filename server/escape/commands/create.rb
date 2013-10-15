require 'pbkdf2'

module Escape::Commands

  def self.create(context, name_and_pass)
    Create.do(context, name_and_pass)
  end

  def self.create_help
    Create.help
  end

  module Create
    class << self

      def help
        'Create a character with "create <name> <password>"'
      end

      def do(context, name_and_pass)
        verify(context)
        name, pass = prepare_args(name_and_pass)
        char = Char.create(name: name,
                           pass: hash_pass(pass),
                           x: 0,
                           y: 0,
                           last_seen_at: DateTime.now)
        if char.save
          context.set[:char_id] = char.id
          "Welcome, #{char.name}! Please remember your password, we don't ask your email, \
    so it's not recoverable."
        else
          binding.pry
          "Try again"
        end
      end

      private

      def verify(context)
        raise 'You are already logged in' if context.char
      end

      def prepare_args(name_and_pass)
        raise help unless name_and_pass

        name, pass = name_and_pass.split(' ', 2)
        raise help unless name && pass
        [name, pass]
      end

      def hash_pass(pass)
        PBKDF2.new(password: pass, salt: Escape::Constants::SALT, iterations: 10000)
      end
    end
  end
end
