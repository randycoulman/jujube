module Jujube
  module Components

    # Helper methods for creating builder components.
    module Builders

      # Specify a `shell` builder for a job.
      #
      # See {http://docs.openstack.org/infra/jenkins-job-builder/builders.html#builders.shell}.
      #
      # @param command [String] The shell command to execute.
      # @return [Hash] The specification for the component.
      def shell(command)
        {'shell' => command}
      end

    end
  end
end
