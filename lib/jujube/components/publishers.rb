module Jujube
  module Components
    standard_component :archive, :cppcheck, :email_ext, :ircbot, :junit, :trigger

    def xunit(options = {}, &block)
      to_config("xunit", nested_options(:types, options, &block))
    end

    named_config :unittest
  end
end
