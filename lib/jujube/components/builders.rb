module Jujube
  module Components

    # Helper methods for creating builder components.
    module Builders
      extend Macros

      # @!method copyartifact(options = {})
      # Specify a `copyartifact` builder for a job. Requires the `copyartifact` plugin.
      #
      # See {https://jenkins-job-builder.readthedocs.io/en/latest/builders.html#builders.copyartifact}.
      #
      # @param options [Hash] The configuration options for the component.
      # @return [Hash] The specification for the component.
      standard_component :copyartifact

      # Specify a `shell` builder for a job.
      #
      # See {https://jenkins-job-builder.readthedocs.io/en/latest/builders.html#builders.shell}.
      #
      # @param command [String] The shell command to execute.
      # @return [Hash] The specification for the component.
      def shell(command)
        {'shell' => command}
      end
    end
  end
end
