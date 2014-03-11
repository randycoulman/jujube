module Jujube
  class JobLoader
    def load_jobs(*pathnames)
      Job.all_defined_during do
        pathnames.each do |path|
          load_one(path)
        end
      end
    end

    private

    def load_one(path)
      if path.directory?
        load_directory(path)
      else
        load_file(path)
      end
    end

    def load_directory(path)
      path.each_child do |child|
        load_one(child)
      end
    end

    def load_file(path)
      load(path)
    end
  end
end
