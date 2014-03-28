module Jujube
  # The top-level DSL to be used when defining jobs.
  module DSL
    include Jujube::Components

    # Define a new Jenkins job.
    #
    # Takes a configuration block that is used to configure the job by
    # setting attribute values and adding components to the various sections
    # of the job.
    #
    # @example
    #   job "my-job" do |j|
    #     j.description = "This is my job."  # Specify attributes
    #     j.quiet_period = 5
    #
    #     j.axes << slave(:arch, %w{i386 amd64}) # Add components to sections
    #
    #     j.scm << git(url: "https://example.com/git/my-project", branches: %w{master dev})
    #
    #     j.triggers << pollscm("@hourly")
    #
    #     j.wrappers << timeout(type: 'elastic', elastic_percentage: 150, elastic_default_timeout: 5, fail: true)
    #     j.wrappers << timestamps
    #
    #     j.builders << shell("bundle && bundle exec rake deploy")
    #
    #     j.publishers << email_ext(recipients: %w{me@example.com you@example.com})
    #   end
    #
    # @param name [String] The name of the job as will be shown by Jenkins.
    # @yieldparam job [Job] The job being created.
    def job(name, &block)
      Job.new(name, &block)
    end

  end
end

# Extend the main object with the DSL commands.  This allows top-level
# calls to the DSL functions to work from a job file without polluting
# the object inheritance tree.
self.extend Jujube::DSL
