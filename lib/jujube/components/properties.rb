module Jujube
  module Components

    # Helper methods for creating property components.
    module Properties
      extend Macros

      # @!method priority_sorter(options = {})
      # Specify a `priority-sorter` property for a job.
      #
      # See {http://docs.openstack.org/infra/jenkins-job-builder/properties.html#properties.priority-sorter}.
      #
      # @param options [Hash] The configuration options for the component.
      # @return [Hash] The specification for the component.
      standard_component :priority_sorter

      # @!method throttle(options = {})
      # Specify a `throttle` property for a job.
      #
      # See {http://docs.openstack.org/infra/jenkins-job-builder/properties.html#properties.throttle}.
      #
      # @param options [Hash] The configuration options for the component.
      # @return [Hash] The specification for the component.
      standard_component :throttle
    end
  end
end

