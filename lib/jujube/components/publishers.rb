module Jujube
  module Components

    # Helper methods for creating publisher components.
    module Publishers
      extend Macros

      # @!method archive(options = {})
      # Specify an `archive` publisher for a job.
      #
      # See {http://ci.openstack.org/jenkins-job-builder/publishers.html#publishers.archive}.
      #
      # @param options [Hash] The configuration options for the component.
      # @return [Hash] The specification for the component.
      standard_component :archive

      # @!method cppcheck(options = {})
      # Specify a `cppcheck` publisher for a job.
      #
      # See {http://ci.openstack.org/jenkins-job-builder/publishers.html#publishers.cppcheck}.
      #
      # @param options [Hash] The configuration options for the component.
      # @return [Hash] The specification for the component.
      standard_component :cppcheck

      # @!method email_ext(options = {})
      # Specify an `email-ext` publisher for a job.
      #
      # See {http://ci.openstack.org/jenkins-job-builder/publishers.html#publishers.email-ext}.
      #
      # @param options [Hash] The configuration options for the component.
      # @return [Hash] The specification for the component.
      standard_component :email_ext

      # @!method fitnesse(options = {})
      # Specify a `fitnesse` publisher for a job.
      #
      # This publisher requires support in jenkins-job-builder that has not yet been merged.
      # See {https://review.openstack.org/87711} for the patch.
      #
      # @param options [Hash] The configuration options for the component.
      # @return [Hash] The specification for the component.
      standard_component :fitnesse

      # @!method ircbot(options = {})
      # Specify an `ircbot` publisher for a job.
      #
      # See {http://ci.openstack.org/jenkins-job-builder/publishers.html#publishers.ircbot}.
      #
      # @param options [Hash] The configuration options for the component.
      # @return [Hash] The specification for the component.
      standard_component :ircbot

      # @!method junit(options = {})
      # Specify a `junit` publisher for a job.
      #
      # See {http://ci.openstack.org/jenkins-job-builder/publishers.html#publishers.junit}.
      #
      # @param options [Hash] The configuration options for the component.
      # @return [Hash] The specification for the component.
      standard_component :junit

      # @!method trigger(options = {})
      # Specify a `trigger` publisher for a job.
      #
      # See {http://ci.openstack.org/jenkins-job-builder/publishers.html#publishers.trigger}.
      #
      # @param options [Hash] The configuration options for the component.
      # @return [Hash] The specification for the component.
      standard_component :trigger

      # Specify an `xunit` publisher for a job.
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
      # @return [Hash] The specification for the component.
      def xunit(options = {}, &block)
        to_config("xunit", nested_options(:types, options, &block))
      end

      # @!group xunit Test Types

      # @!method unittest(options = {})
      # Configure a `unittest` test type for an {#xunit} publisher.
      #
      # See {http://ci.openstack.org/jenkins-job-builder/publishers.html#publishers.xunit}.
      #
      # @param options [Hash] The configuration options for the test type.
      # @return [Hash] The specification for the test type.
      named_config :unittest

    end
  end
end
