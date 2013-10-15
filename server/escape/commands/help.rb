module Escape::Commands

  def self.help(context, command)
    if Help.all_commands.include?(command)
      help_cmd = "#{command}_help"
      if Escape::Commands.respond_to? help_cmd
        Escape::Commands.send(help_cmd)
      else
        "No help for #{command}, just try running it"
      end
    else
      "Available commands: #{Help.all_commands.join(', ')}\n" +
      "Type \"help <command>\" to dig deeper."
    end
  end

  module Help
    class << self

      def all_commands
        unless defined?(ALL_COMMANDS)
          all_commands = Dir.entries(File.dirname(__FILE__))
                            .map { |d| d.gsub('.rb', '') }
                            .reject { |d| d.start_with? '.' }
          const_set(:ALL_COMMANDS, all_commands)
        end
        ALL_COMMANDS
      end
    end
  end

end
