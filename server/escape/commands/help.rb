module Escape::Commands

  def self.help(context, command)
    Help.do(context, command)
  end

  module Help

    ANONYMOUS_COMMANDS = ['signup', 'login', 'help'].sort
    ANONYMOUS_ONLY_COMMANDS = ['signup', 'login']
    HIDDEN_COMMANDS = ['refresh']

    class << self

      def do(context, command)
        if all_commands.include?(command)
          help_cmd = "#{command}_help"
          if Escape::Commands.respond_to? help_cmd
            Escape::Commands.send(help_cmd)
          else
            "No help for #{command}, just try running it"
          end
        else
          commands = if context.logged_in?
            all_commands.reject { |c| (HIDDEN_COMMANDS + ANONYMOUS_ONLY_COMMANDS).include?(c) }
          else
            ANONYMOUS_COMMANDS
          end
          "Available commands: #{commands.join(', ')}\n" +
          "Type \"help <command>\" to dig deeper."
        end
      end

      private

      def all_commands
        unless defined?(ALL_COMMANDS)
          all_commands = Dir.entries(File.dirname(__FILE__))
                            .map { |f| f.gsub('.rb', '') }
                            .reject { |c| c.start_with? '.' }
                            .select { |c| Escape::Commands.respond_to?(c) }
          const_set(:ALL_COMMANDS, all_commands)
        end
        ALL_COMMANDS
      end
    end
  end

end
