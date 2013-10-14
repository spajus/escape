require_relative 'commands/help'
module Escape::Commands

  def self.run(command)
    cmd, params = command.split(' ', 2)

    if Escape::Commands.respond_to?(cmd)
      Escape::Commands.send(cmd, params)
    else
      "Unknown command: \"#{cmd}\". Try \"help\"."
    end
  end

end
