module Jujube
  module Components

    # Helper methods for creating job parameter components.
    module Parameters
      extend Macros

      # @!method string(options = {})
      # Specify a `string` parameter for a job.
      #
      # See {http://docs.openstack.org/infra/jenkins-job-builder/parameters.html#parameters.string}.
      #
      # @param options [Hash] The configuration options for the component.
      # @return [Hash] The specification for the component.
      standard_component :string

      # @!method validating_string(options = {})
      # Specify a `validating-string` parameter for a job.
      #
      # See {http://docs.openstack.org/infra/jenkins-job-builder/parameters.html#parameters.validating-string}.
      #
      # @param options [Hash] The configuration options for the component.
      # @return [Hash] The specification for the component.
      standard_component :validating_string
    end
  end
end
