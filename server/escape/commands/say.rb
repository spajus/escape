module Escape::Commands

  def self.say(context, message)
    Say.say(context, message)
  end

  def self.whisper(context, args)
    Say.whisper(context, args)
  end

  def self.emote(context, message)
    Say.emote(context, message)
  end

  def self.say_help
    "Say something to everyone. Use whisper <name> <message> to talk to just someone."
  end

  module Say
    module Methods

      include Escape::Models

      def say(context, message)
        Message.say(context.char, message)
      end

      def emote(context, message)
        Message.emote(context.char, message)
      end

      def whisper(context, args)
        to, message = args.split(' ', 2)
        receiver = Escape::Models::Char.where(name: to).first
        raise Escape::BadCommand("Don't know who #{to} is") unless receiver
        Message.whisper(context.char, receiver, message)
      end

    end

    extend Methods
  end
end
