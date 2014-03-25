module Jujube
  module Components
    include Jujube::Utils

    def self.named_config(*names)
    names.each do |name|
        define_method(name) do |options = {}|
          to_config(canonicalize(name), options)
        end
      end
    end

    class << self
      alias_method :standard_component, :named_config
    end

    def to_config(key, options)
      return key if options.empty?

      {key => canonicalize_options(options)}
    end
  end
end
