module Jujube
  module Utils
    def canonicalize(key)
      key.to_s.gsub("_", "-")
    end

    module_function :canonicalize
  end
end
