module Jujube
  module Components
    # @!group Wrappers

    standard_component :timeout

    # Define a `timestamps` component for a job.
    #
    # See {http://ci.openstack.org/jenkins-job-builder/wrappers.html#wrappers.timestamps}.
    def timestamps
      'timestamps'
    end

    # @!endgroup
  end
end
