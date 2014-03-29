module Jujube
  module Components

    # Helper methods for creating SCM components.
    module Scm
      extend Macros

      # @!method git(options = {})
      # Specify a `git` component for a job.
      #
      # See {http://ci.openstack.org/jenkins-job-builder/publishers.html#scm.git}.
      #
      # @param options [Hash] The configuration options for the component.
      # @return [Hash] The specification for the component.
      standard_component :git

    end
  end
end
