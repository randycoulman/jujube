require_relative "macros"
require 'yaml'

module Jujube
  # Models a single Jenkins job.
  class Job
    extend Macros

    # Initialize the job.
    #
    # Takes a configuration block for adding atributes and sections to the job.
    # The configuration block is passed the new `Job` as a parameter.
    #
    # @param job_name [String] The name of the job.  Will be the name as seen in Jenkins.
    # @yieldparam self [Job] Passes itself to the configuration block.
    def initialize(job_name)
      @config = {}
      self.name = job_name

      yield(self) if block_given?

      self.class.register(self)
    end

    attribute :name, :project_type, :description, :node, :block_upstream, :block_downstream, :quiet_period
    section :axes, :scm, :triggers, :wrappers, :builders, :publishers, :notifications

    # Generate a YAML representation of the `Job`.
    def to_yaml(*args)
      to_h.to_yaml(*args)
    end

    # Generate a `Hash` repsentation of the `Job`.
    def to_h
      infer_project_type
      {'job' => config}
    end

    # Keep track of all `Job`s defined during the execution of the passed block.
    #
    # This is used during job loading so that no extra syntax is required in the job
    # definition files for registering jobs and so that it is possible to create jobs
    # for testing purposes without having them registered anywhere.
    #
    # @return [Array<Job>] Returns a list of all `Job`s defined within the block.
    def self.all_defined_during
      @registry = []
      yield
      @registry
    ensure
      @registry = []
    end

    # Register a `Job` in a registry.
    #
    # If no registry is active, this is a no-op.
    #
    # @param job [Job] The job to register.
    def self.register(job)
      @registry << job if @registry
    end

    # The job configuration.
    #
    # All configuration is stored internally as a `Hash` with `String` keys in
    # canonical jenkins-job-builder format.  This format can readily be converted
    # to the YAML needed by jenkins-job-builder.
    attr_reader :config
    private :config

    private

    # Set the {#project_type} to `matrix` if any `axes` have been specified.
    def infer_project_type
      self.project_type = "matrix" if has_axes?
    end

    # Have any `axes` been specified?
    #
    # Take care to not lazily-initialize an `"axes"` key when checking.
    #
    # @return [Boolean] `true` if any `axes` have been defined; `false` otherwise.
    def has_axes?
      config.has_key?("axes") && !axes.empty?
    end
  end
end
