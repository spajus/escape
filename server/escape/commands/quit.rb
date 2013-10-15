module Escape::Commands

  def self.quit(context, args)
    if context.logged_in?
      context.logout
      "You are now logged out"
    else
      "You were not logged in"
    end
  end

  def self.quit_help
    "Logs your character out"
  end
end
