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

    # @!group Attributes

    # @!attribute name
    #   The name of the job - will be the name as seen in Jenkins.
    #
    #   See {https://jenkins-job-builder.readthedocs.io/en/latest/definition.html}.
    #
    #   @return [String]
    attribute :name

    # @!attribute project_type
    #   The type of job. This normally does not need to be specified, as it
    #   will be inferred as `matrix` if any `axes` are added.
    #
    #   See {https://jenkins-job-builder.readthedocs.io/en/latest/definition.html}.
    #
    #   @return [String]
    attribute :project_type

    # @!attribute description
    #   The description of the job.
    #
    #   See {https://jenkins-job-builder.readthedocs.io/en/latest/definition.html}.
    #
    #   @return [String]
    attribute :description

    # @!attribute node
    #   The Jenkins node or named group where the job should be run.
    #
    #   See {https://jenkins-job-builder.readthedocs.io/en/latest/definition.html}.
    #
    #   @return [String]
    attribute :node

    # @!attribute block_upstream
    #   `true` if this job should block while upstream jobs are running.
    #
    #   See {https://jenkins-job-builder.readthedocs.io/en/latest/definition.html}.
    #
    #   @return [Boolean]
    attribute :block_upstream

    # @!attribute block_downstream
    #   `true` if this job should block while downstream jobs are running.
    #
    #   See {https://jenkins-job-builder.readthedocs.io/en/latest/definition.html}.
    #
    #   @return [Boolean]
    attribute :block_downstream

    # @!attribute quiet_period
    #   Number of seconds to wait between consecutive runs of the job.
    #
    #   See {https://jenkins-job-builder.readthedocs.io/en/latest/definition.html}.
    #
    #   @return [Fixnum]
    attribute :quiet_period

    # @!attribute concurrent
    #   `true` if this job should be concurrent.
    #
    #   See {https://jenkins-job-builder.readthedocs.io/en/latest/definition.html?highlight=concurrent}.
    #
    #   @return [Boolean]
    attribute :concurrent

    # @!attribute disabled
    #   `true` if this job should be disabled.
    #
    #   See {https://jenkins-job-builder.readthedocs.io/en/latest/definition.html}.
    #
    #   @return [Boolean]
    attribute :disabled

    # @!endgroup

    # @!group Sections

    # Sections are listed in the order specified under Module Execution in the
    # Jenkins Job Builder documentation.
    #
    # See {https://jenkins-job-builder.readthedocs.io/en/latest/definition.html#module-execution}.

    # @!method axes
    #   The matrix axes for the job.
    #
    #   Add axes in the job's configuration block using helper methods defined in
    #   {Components::Parameters}.
    #
    #   See {https://jenkins-job-builder.readthedocs.io/en/latest/project_matrix.html}.
    #
    #   @return [Array]
    section :axes

    # @!method parameters
    #   The parameters for the job.
    #
    #   Add parameters in the job's configuration block using helper methods defined in
    #   {Components::Parameters}.
    #
    #   See {https://jenkins-job-builder.readthedocs.io/en/latest/parameters.html}.
    #
    #   @return [Array]
    section :parameters

    # @!method properties
    #   The Properties for the job.
    #
    #   Add properties in the job's configuration block using helper methods defined in
    #   {Components::Properties}.
    #
    #   See {https://jenkins-job-builder.readthedocs.io/en/latest/properties.html}.
    #
    #   @return [Array]
    section :properties

    # @!method scm
    #   The SCMs for the job.
    #
    #   Add SCMs in the job's configuration block using helper methods defined in
    #   {Components::Scm}.
    #
    #   See {https://jenkins-job-builder.readthedocs.io/en/latest/scm.html}.
    #
    #   @return [Array]
    section :scm

    # @!method triggers
    #   The triggers for the job.
    #
    #   Add triggers in the job's configuration block using helper methods defined in
    #   {Components::Triggers}.
    #
    #   See {https://jenkins-job-builder.readthedocs.io/en/latest/triggers.html}.
    #
    #   @return [Array]
    section :triggers

    # @!method wrappers
    #   The wrappers for the job.
    #
    #   Add wrappers in the job's configuration block using helper methods defined in
    #   {Components::Wrappers}.
    #
    #   See {https://jenkins-job-builder.readthedocs.io/en/latest/wrappers.html}.
    #
    #   @return [Array]
    section :wrappers

    # @!method builders
    #   The builders for the job.
    #
    #   Add builders in the job's configuration block using helper methods defined in
    #   {Components::Builders}.
    #
    #   See {https://jenkins-job-builder.readthedocs.io/en/latest/builders.html}.
    #
    #   @return [Array]
    section :builders

    # @!method publishers
    #   The publishers for the job.
    #
    #   Add publishers in the job's configuration block using helper methods defined in
    #   {Components::Publishers}.
    #
    #   See {https://jenkins-job-builder.readthedocs.io/en/latest/publishers.html}.
    #
    #   @return [Array]
    section :publishers

    # @!method notifications
    #   The notifications for the job.
    #
    #   Add notifications in the job's configuration block using helper methods defined in
    #   {Components::Notifications}.
    #
    #   See {https://jenkins-job-builder.readthedocs.io/en/latest/notifications.html}.
    #
    #   @return [Array]
    section :notifications

    # @!endgroup

    # Generate a YAML representation of the `Job`.
    def to_yaml(*args)
      to_h.to_yaml(*args)
    end

    # Generate a `Hash` repsentation of the `Job`.
    def to_h
      infer_project_type
      {'job' => config}
    end

    @registry = nil

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
