module Jujube
  module Components

    # Helper methods for creating wrapper components.
    module Wrappers
      extend Macros

      # @!method timeout(options = {})
      # Specify a `timeout` wrapper for a job.
      #
      # See {https://jenkins-job-builder.readthedocs.io/en/latest/publishers.html#wrappers.timeout}.
      #
      # @param options [Hash] The configuration options for the component.
      # @return [Hash] The specification for the component.
      standard_component :timeout

      # Specify a `timestamps` wrapper for a job.
      #
      # See {https://jenkins-job-builder.readthedocs.io/en/latest/wrappers.html#wrappers.timestamps}.
      #
      # @return [Hash] The specification for the component.
      def timestamps
        'timestamps'
      end

    end
  end
end
