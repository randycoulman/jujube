require_relative "components/macros"
require_relative "components/helpers"
require_relative "components/axes"
require_relative "components/parameters"
require_relative "components/properties"
require_relative "components/scm"
require_relative "components/triggers"
require_relative "components/wrappers"
require_relative "components/builders"
require_relative "components/publishers"
require_relative "components/notifications"

module Jujube
  # Helper methods for creating jenkins-job-builder components.
  module Components
    include Helpers
    include Axes
    include Parameters
    include Properties
    include Scm
    include Triggers
    include Wrappers
    include Builders
    include Publishers
    include Notifications
  end
end
