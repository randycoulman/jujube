module Jujube
  module Components
    standard_component :archive, :cppcheck, :email_ext, :ircbot, :junit, :trigger

    def xunit(options = {})
      types = []
      yield(types) if block_given?
      options.merge!(types: types) unless types.empty?
      to_config("xunit", options)
    end

    standard_component :unittest
  end
end
