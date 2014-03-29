module Jujube
  module Components

    # Macros for defining components and their nested configuration elements
    module Macros
      include Jujube::Utils

      private

      # A macro that defines a standard component.  A standard
      # component has a name and a `Hash` of named options.  The name and all option
      # keys are {#canonicalize}d.
      #
      # @param name [Symbol] The name of the component to generate.
      def standard_component(name)
        named_config(name)
      end

      # A macro that defines methods that generate a standard named
      # configuration.  A standard named configuration has a name and a `Hash`
      # of named options.  The names and all option keys are {#canonicalize}d.
      #
      # @param name [Symbol] The name of the method to generate.
      def named_config(name)
        define_method(name) do |options = {}|
          to_config(canonicalize(name), options)
        end
      end
    end
  end
end
