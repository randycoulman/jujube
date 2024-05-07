module Jujube
  module Components

    # Helper methods for creating publisher components.
    module Publishers
      extend Macros

      # @!method archive(options = {})
      # Specify an `archive` publisher for a job.
      #
      # See {http://docs.openstack.org/infra/jenkins-job-builder/publishers.html#publishers.archive}.
      #
      # @param options [Hash] The configuration options for the component.
      # @return [Hash] The specification for the component.
      standard_component :archive

      # @!method cppcheck(options = {})
      # Specify a `cppcheck` publisher for a job.
      #
      # See {http://docs.openstack.org/infra/jenkins-job-builder/publishers.html#publishers.cppcheck}.
      #
      # @param options [Hash] The configuration options for the component.
      # @return [Hash] The specification for the component.
      standard_component :cppcheck

      # @!method email_ext(options = {})
      # Specify an `email-ext` publisher for a job.
      #
      # See {http://docs.openstack.org/infra/jenkins-job-builder/publishers.html#publishers.email-ext}.
      #
      # @param options [Hash] The configuration options for the component.
      # @return [Hash] The specification for the component.
      standard_component :email_ext

      # @!method fitnesse(options = {})
      # Specify a `fitnesse` publisher for a job.
      #
      # See {http://docs.openstack.org/infra/jenkins-job-builder/publishers.html#publishers.fitnesse}.
      #
      # @param options [Hash] The configuration options for the component.
      # @return [Hash] The specification for the component.
      standard_component :fitnesse

      # @!method gitlab_notifier(options = {})
      # Specify a `gitlab-notifier` publisher for a job.
      #
      # See {https://docs.openstack.org/infra/jenkins-job-builder/publishers.html#publishers.gitlab-notifier}.
      #
      # @param options [Hash] The configuration options for the component.
      # @return [Hash] The specification for the component.
      standard_component :gitlab_notifier

      # @!method ircbot(options = {})
      # Specify an `ircbot` publisher for a job.
      #
      # See {http://docs.openstack.org/infra/jenkins-job-builder/publishers.html#publishers.ircbot}.
      #
      # @param options [Hash] The configuration options for the component.
      # @return [Hash] The specification for the component.
      standard_component :ircbot

      # @!method junit(options = {})
      # Specify a `junit` publisher for a job.
      #
      # See {http://docs.openstack.org/infra/jenkins-job-builder/publishers.html#publishers.junit}.
      #
      # @param options [Hash] The configuration options for the component.
      # @return [Hash] The specification for the component.
      standard_component :junit

      # @!method trigger(options = {})
      # Specify a `trigger` publisher for a job.
      #
      # See {http://docs.openstack.org/infra/jenkins-job-builder/publishers.html#publishers.trigger}.
      #
      # @param options [Hash] The configuration options for the component.
      # @return [Hash] The specification for the component.
      standard_component :trigger

      # Specify a `trigger-parameterized-builds` publisher for a job.
      #
      # See {http://docs.openstack.org/infra/jenkins-job-builder/publishers.html#publishers.trigger-parameterized-builds}.
      #
      # `trigger-parameterized-builds` can trigger multiple sets of builds,
      # each with their own configuration.  Each build specification is added
      # in a nested configuration block using the {#build} method.
      #
      # @example
      #   job "trigger-parameterized-builds-example" do |j|
      #     j.publishers << trigger_parameterized_builds do |builds|
      #       builds << build(project: %w[PROJECT1 PROJECT2], condition: "SUCCESS")
      #       builds << build(project: "SINGLE_PROJECT", current_parameters: true)
      #     end
      #   end
      #
      # @yieldparam builds [Array] An array to which nested build specifications
      #   should be added by the block.
      # @return [Hash] The specification for the component.
      def trigger_parameterized_builds
        builds = []
        yield(builds) if block_given?
        {"trigger-parameterized-builds" => builds}
      end

      # Specify an `xunit` publisher for a job.
      #
      # See {http://docs.openstack.org/infra/jenkins-job-builder/publishers.html#publishers.xunit}.
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

      # @!group trigger_parameterized_builds Builds

      # Configure a `build` for a {#trigger_parameterized_builds} publisher.
      #
      # See {http://docs.openstack.org/infra/jenkins-job-builder/publishers.html#publishers.trigger-parameterized-builds}.
      #
      # @param options [Hash] The configuration options for the build.
      # @return [Hash] The specification for the build.
      def build(options = {})
        identity = ->(value) { value }
        transforms = {
            predefined_parameters: ->(value) do
              result = value.map { |k,v| "#{k}=#{v}" }.join("\n")
              value.size > 1 ? result + "\n" : result
            end,
            boolean_parameters: ->(value) do
              Hash[value.map { |k,v| [k.to_s, v] }]
            end,
            git_revision: ->(value) do
              value.is_a?(Hash) ? canonicalize_options(value) : value
            end
        }
        transformed_options = options.map do |k, v|
          transform = transforms.fetch(k) { identity }
          [k, transform.call(v)]
        end

        canonicalize_options(Hash[transformed_options])
      end

      # @!endgroup

      # @!group xunit Test Types

      # @!method gtest(options = {})
      # Configure a `gtest` test type for an {#xunit} publisher.
      #
      # See {https://jenkins-job-builder.readthedocs.io/en/latest/publishers.html#publishers.xunit}.
      #
      # @param options [Hash] The configuration options for the test type.
      # @return [Hash] The specification for the test type.
      named_config :gtest

      # @!method unittest(options = {})
      # Configure a `unittest` test type for an {#xunit} publisher.
      #
      # See {http://docs.openstack.org/infra/jenkins-job-builder/publishers.html#publishers.xunit}.
      #
      # @param options [Hash] The configuration options for the test type.
      # @return [Hash] The specification for the test type.
      named_config :unittest

      # @!endgroup
    end
  end
end
