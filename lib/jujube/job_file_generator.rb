module Jujube
  class JobFileGenerator
    def generate(jobs, output)
      output.dirname.mkpath
      output.open("w") do |io|
        jobs.map(&:to_h).to_yaml(io)
      end
    end
  end
end
