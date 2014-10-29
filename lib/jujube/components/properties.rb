module Jujube
  module Components

    # Helper methods for creating property components.
    module Properties
      extend Macros

      # @!method throttle(options = {})
      # Specify a `throttle` property for a job.
      #
      # See {http://ci.openstack.org/jenkins-job-builder/properties.html#properties.throttle}.
      #
      # @param options [Hash] The configuration options for the component.
      # @return [Hash] The specification for the component.
      standard_component :throttle
    end
  end
end

