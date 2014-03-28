module Jujube
  module Utils
    private

    def canonicalize(key)
      key.to_s.gsub("_", "-")
    end

    def canonicalize_options(options)
      Hash[options.map { |k, v| [canonicalize(k), v] }]
    end
  end
end
