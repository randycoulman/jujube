module Jujube
  module Components

    # Helper methods for creating builder components.
    module Builders

      # Define a `shell` builder for a job.
      #
      # See {http://ci.openstack.org/jenkins-job-builder/builders.html#builders.shell}.
      #
      # @param command [String] The shell command to execute.
      def shell(command)
        {'shell' => command}
      end

    end
  end
end
