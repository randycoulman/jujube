module Jujube
  module Components

    # Helper methods for creating publisher components.
    module Publishers
      extend Macros

      standard_component :archive, :cppcheck, :email_ext, :ircbot, :junit, :trigger

      # Define an `xunit` component for a job.
      #
      # See {http://ci.openstack.org/jenkins-job-builder/publishers.html#publishers.xunit}.
      #
      # `xunit` can publish multiple sets of test results.  The specification for each set
      # of test results is added in a nested configuration block using the {#unittest} method.
      #
      # @example
      #    job "xunit-example" do |j|
      #      j.publishers << xunit do |types|
      #        types << unittest(pattern: "PATTERN", deleteoutput: false)
      #      end
      #    end
      #
      # @param options [Hash] Top-level options for configuring the component.
      # @yieldparam types [Array] An array to which nested test type specifications should be
      #   added by the block.
      def xunit(options = {}, &block)
        to_config("xunit", nested_options(:types, options, &block))
      end

      # @!endgroup

      # @!group xunit Test Types

      named_config :unittest

    end
  end
end
