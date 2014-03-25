module Jujube
  module Utils
    def canonicalize(key)
      key.to_s.gsub("_", "-")
    end
    module_function :canonicalize

    def canonicalize_options(options)
      Hash[options.map { |k, v| [Jujube::Utils.canonicalize(k), v] }]
    end

    module_function :canonicalize_options
  end
end
