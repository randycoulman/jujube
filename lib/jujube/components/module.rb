module Jujube

  # Helper methods for creating jenkins-job-builder components.
  module Components
    include Jujube::Utils

    private

    # A macro that defines methods that generate a standard component.  A standard
    # component has a name and a `Hash` of named options.  The names and all option
    # keys are {#canonicalize}d.
    #
    # @param names [Array<Symbol>] The names of the methods to generate.
    def self.standard_component(*names)
      named_config(*names)
    end

    # A macro that defines methods that generate a standard named
    # configuration.  A standard named configuration has a name and a `Hash`
    # of named options.  The names and all option keys are {#canonicalize}d.
    #
    # @param names [Array<Symbol>] Symbols naming the methods to generate.
    def self.named_config(*names)
      names.each do |name|
        define_method(name) do |options = {}|
          to_config(canonicalize(name), options)
        end
      end
    end

    # Build a named array of nested configuration options by yielding to a client-supplied
    # block.
    #
    # @param name [Symbol] The name of the nested configuration options.
    # @param options [Hash] Additional top-level configuration options.
    # @return [Hash] A named configuration that includes the top-level options and all
    #   nested options provided by the client's block.
    # @yieldparam nested [Array] The array of nested options to be built up by the
    #   client-provided block.
    def nested_options(name, options = {})
      nested = []
      yield(nested) if block_given?
      options.merge!(name => nested) unless nested.empty?
      options
    end

    # Convert a name and a set of named options into the canonical `Hash` format
    # required by jenkins-job-builder.
    #
    # @param key [Symbol] The name for the options.
    # @param options [Hash] The named options.
    # @return [Hash, String] The resulting canonical `Hash`.  If no options are
    #   provided, then just the `canonicalize`d name will be returned.
    def to_config(key, options)
      return key if options.empty?

      {key => canonicalize_options(options)}
    end
  end
end
