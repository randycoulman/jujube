require_relative "macros"
require 'yaml'

module Jujube
  class Job
    extend Macros

    def initialize(job_name)
      @config = {}
      self.name = job_name

      yield(self) if block_given?

      self.class.register(self)
    end

    attribute :name, :project_type, :description, :node, :block_upstream, :block_downstream, :quiet_period
    section :axes, :scm, :triggers, :wrappers, :builders, :publishers, :notifications

    def to_yaml(*args)
      to_h.to_yaml(*args)
    end

    def to_h
      infer_project_type
      {'job' => config}
    end

    def self.all_defined_during
      @registry = []
      yield
      @registry
    ensure
      @registry = []
    end

    def self.register(job)
      @registry << job if @registry
    end

    attr_reader :config
    private :config

    private

    def infer_project_type
      self.project_type = "matrix" if has_axes?
    end

    def has_axes?
      config.has_key?("axes") && !axes.empty?
    end
  end
end
