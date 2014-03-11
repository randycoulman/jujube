module Jujube
  module Components
    include Jujube::Utils

    def self.standard_component(*names)
      names.each do |name|
        define_method(name) do |options = {}|
          to_config(canonicalize(name), options)
        end
      end
    end

    def to_config(key, options)
      return key if options.empty?

      config = Hash[options.map { |k, v| [Jujube::Utils.canonicalize(k), v] }]
      {key => config}
    end
  end
end
