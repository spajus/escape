module Escape
  require_relative 'commands'
  require_relative 'models'
  require_relative 'context'
  require_relative 'constants'
  require_relative 'logic/direction'
  require_relative 'logic/area'

  class BadCommand < Exception
  end
end
