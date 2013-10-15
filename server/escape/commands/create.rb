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
        char = Escape::Models::Char.new(name: name,
                                        pass: pass,
                                        x: 0,
                                        y: 0,
                                        last_seen_at: DateTime.now)
        if char.valid? && char.save
          welcome = context.login(char)
          "#{welcome} Please remember your password, we don't ask your email, " +
          "so it's not recoverable."
        else
          errors = char.errors.map { |f, e| "#{f} #{e}" }
          "Cannot create character: #{errors.join(", ")}"
        end
      end
    end

    module SharedMethods
      def verify(context)
        raise Escape::BadCommand.new('You are already logged in') if context.logged_in?
      end

      def prepare_args(name_and_pass)
        raise Escape::BadCommand.new(help) unless name_and_pass

        name, pass = name_and_pass.split(' ', 2)
        raise Escape::BadCommand.new(help) unless name && pass

        pass = hash_pass(pass)
        [name, pass]
      end

      private

      def hash_pass(pass)
        OpenSSL::PKCS5.pbkdf2_hmac_sha1(pass, Escape::Constants::SALT, 4096, 16)
                      .unpack('H*')
                      .first
      end
    end

    extend SharedMethods
  end
end
