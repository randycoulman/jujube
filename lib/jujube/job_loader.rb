module Jujube

  # Loads job definitions from a set of files and/or directories.
  class JobLoader

    # Load job definitions from one or more files and/or directories.
    #
    # The job definition files are loaded as Ruby files; it is expected that
    # will make use of the {DSL#job} DSL function, but they can contain other
    # Ruby code as well.
    #
    # @param pathnames [Pathname...] The file or directory names containing
    # the job definitions.
    def load_jobs(*pathnames)
      Job.all_defined_during do
        pathnames.each do |path|
          load_one(path)
        end
      end
    end

    private

    # Load jobs from a single file or directory
    #
    # @param path [Pathname] The file or directory to load from.
    def load_one(path)
      if path.directory?
        load_directory(path)
      else
        load_file(path)
      end
    end

    # Load jobs from all (recursive) files in a directory.
    #
    # @param path [Pathname] The directory to search.
    def load_directory(path)
      path.each_child do |child|
        load_one(child)
      end
    end

    # Load jobs from a single file.
    #
    # @param path [Pathname] The file to load.
    def load_file(path)
      load(path)
    end
  end
end
