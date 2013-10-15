require_relative 'commands/help'
require_relative 'commands/create'

module Escape::Commands

  module Runner

    class << self
      def run(command, context)
        cmd, params = command.split(' ', 2)

        if Escape::Commands.respond_to?(cmd)
          safe_send(cmd, context, params)
        else
          "Unknown command: \"#{cmd}\". Try \"help\"."
        end
      end

      private

      def safe_send(cmd, context, params)
        Escape::Commands.send(cmd, context, params)
      rescue => e
        puts e
        puts e.backtrace.join("\n")
        "#{e}"
      end
    end
  end

end
