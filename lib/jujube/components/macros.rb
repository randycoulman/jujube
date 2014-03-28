module Jujube
  module Components

    # Macros for defining components and their nested configuration elements
    module Macros
      include Jujube::Utils

      # A macro that defines methods that generate a standard component.  A standard
      # component has a name and a `Hash` of named options.  The names and all option
      # keys are {#canonicalize}d.
      #
      # @param names [Array<Symbol>] The names of the methods to generate.
      def standard_component(*names)
        named_config(*names)
      end

      # A macro that defines methods that generate a standard named
      # configuration.  A standard named configuration has a name and a `Hash`
      # of named options.  The names and all option keys are {#canonicalize}d.
      #
      # @param names [Array<Symbol>] Symbols naming the methods to generate.
      def named_config(*names)
        names.each do |name|
          define_method(name) do |options = {}|
            to_config(canonicalize(name), options)
          end
        end
      end
    end
  end
end
