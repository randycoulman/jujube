module Jujube
  module Components

    # Helper methods for creating wrapper components.
    module Wrappers
      extend Macros

      standard_component :timeout

      # Define a `timestamps` component for a job.
      #
      # See {http://ci.openstack.org/jenkins-job-builder/wrappers.html#wrappers.timestamps}.
      def timestamps
        'timestamps'
      end

    end
  end
end
