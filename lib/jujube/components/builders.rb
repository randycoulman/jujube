module Jujube
  module Components

    # @!group Builders

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
