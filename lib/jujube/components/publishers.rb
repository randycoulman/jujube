module Jujube
  module Components
    standard_component :archive, :cppcheck, :email_ext, :ircbot, :junit, :trigger

    def xunit(options = {})
      types = []
      yield types if block_given?
      to_config("xunit", options.merge({types: types}))
    end

    standard_component :unittest
  end
end
