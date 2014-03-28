module Jujube
  # Private utility methods.
  module Utils
    private

    # Convert a hash key into the canonical format required by
    # jenkins-job-builder.  Keys must be strings and use
    # dashes (`-`) instead of underscores (`_`).
    #
    # @param key [Symbol] The key to canonicalize.
    # @return [String] The key in canonical format.
    def canonicalize(key)
      key.to_s.gsub("_", "-")
    end

    # Ensure that all of the keys in an options hash are in
    # canonical jenkins-job-builder format.  This method only
    # looks at the top-level keys; it assumes that any
    # nested hashes have already been {#canonicalize}d.
    #
    # @param options [Hash] The options to canonicalize.
    # @return [Hash] The options in canonical format.
    def canonicalize_options(options)
      Hash[options.map { |k, v| [canonicalize(k), v] }]
    end
  end
end
