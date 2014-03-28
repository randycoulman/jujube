module Jujube
  # Generate a YAML file suitable for jenkins-job-builder.
  class JobFileGenerator

    # Generate a jenkins-job-builder YAML file for a list of jobs.
    #
    # @param jobs [Array] The job definitions to include in the output.
    # @param output [Pathname] The output file to generate.  Any intermediate
    #   directories are created automatically.
    def generate(jobs, output)
      output.dirname.mkpath
      output.open("w") do |io|
        jobs.map(&:to_h).to_yaml(io)
      end
    end
  end
end
