require_relative "job_loader"
require_relative "job_file_generator"
require 'optparse'
require 'ostruct'
require 'pathname'

module Jujube

  # The command-line driver for the Jujube application.
  class Driver

    # Run the Jujube application.
    def self.run
      self.new.run
    end

    # Initialize the driver.
    #
    # @param loader [JobLoader] Loads jobs from user-specified files and/or directories.
    # @param generator [JobFileGenerator] Generates the jenkins-job-builder YAML file from
    #   any jobs that have been loaded.
    def initialize(loader = JobLoader.new, generator = JobFileGenerator.new)
      @loader = loader
      @generator = generator
    end

    # Run the Jujube application.
    #
    # @param argv [Array] The command-line arguments that control the application.
    def run(argv = ARGV)
      argv = adjusted_for_jruby(argv)
      options = handle_options(argv)
      jobs = @loader.load_jobs(*options.paths || Pathname.getwd)
      @generator.generate(jobs, options.output || Pathname.new("jobs.yml"))
    end

    private

    # Parse the command-line options.
    #
    # @param argv [Array] The command-line options.
    # @return [OpenStruct] The options specified on the command-line.  May include
    #   `paths`, a list of `Pathname`s to load and `output`, the `Pathname` of the
    #   output file to generate.
    def handle_options(argv)
      options = OpenStruct.new

      OptionParser.new do |opts|
        opts.banner = "Usage: #{$PROGRAM_NAME} [options] paths..."

        opts.on('-o', '--output FILENAME', 'Specify output file (default = "jobs.yml")') do |file|
          options.output = Pathname.new(file)
        end

        opts.on_tail('-h', '--help', "Display this screen") do
          puts opts
          exit
        end

        opts.on_tail('--version', "Show version") do
          puts VERSION
          exit
        end
      end.parse!(argv)

      options.paths = argv.map { |file| Pathname.new(file) } unless argv.empty?

      options
    end

    # Adjust the command-line arguments for running acceptance tests under JRuby.
    #
    # When running the acceptance tests under JRuby, an extra '{}' argument
    # is passed in ARGV.  We remove it here so that it doesn't affect the
    # rest of the program logic.
    #
    # See {https://github.com/jruby/jruby/issues/1290}.
    def adjusted_for_jruby(argv)
      argv.pop if argv.last == "{}"
      argv
    end
  end
end
