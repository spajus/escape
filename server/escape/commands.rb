require_relative 'commands/help'
require_relative 'commands/refresh'
require_relative 'commands/create'
require_relative 'commands/quit'
require_relative 'commands/login'
require_relative 'commands/describe'
require_relative 'commands/go'

module Escape::Commands

  module Runner

    class << self
      def run(command, context)
        cmd, params = command.split(' ', 2)
        cmd.downcase!

        if Escape::Commands.respond_to?(cmd)
          response = safe_send(cmd, context, params)
          if context.logged_in?
            area = Escape::Logic::Area.chunk(context.char.location)
          end
        else
          response = "Unknown command: \"#{cmd}\". Try \"help\"."
        end
        { res: response, area: area, time: context.since.to_i }
      end

      private

      def safe_send(cmd, context, params)
        Escape::Commands.send(cmd, context, params)
      rescue Escape::BadCommand => e
        "#{e}"
      end
    end
  end
end
