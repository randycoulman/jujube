module Jujube
  module DSL
    include Jujube::Components

    def job(name, &block)
      Job.new(name, &block)
    end

  end
end

# Extend the main object with the DSL commands.  This allows top-level
# calls to the DSL functions to work from a job file without polluting
# the object inheritance tree.
self.extend Jujube::DSL
