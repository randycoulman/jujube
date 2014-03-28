module Jujube
  # Macros for defining methods that make it easier to specify the parts
  # a job.
  module Macros
    include Jujube::Utils

    # A macro that generates methods that define an attribute of a job.
    # For each attribute, it generates a reader and a writer.
    #
    # @param attribute_names [Array<Symbol>] The names of the attributes.
    def attribute(*attribute_names)
      attribute_names.each do |attribute_name|
        canonical_name = canonicalize(attribute_name)

        define_method attribute_name do
          config[canonical_name]
        end

        define_method "#{attribute_name}=".to_sym do |value|
          config[canonical_name] = value
        end
      end
    end

    # A macro that generates methods that define a section of a job.
    # For each section, it generates a method that returns the `Array`
    # of components in that section.
    #
    # @param section_names [Array<Symbol>] The names of the sections.
    def section(*section_names)
      section_names.each do |section_name|
        define_method section_name do
          config[section_name.to_s] ||= []
        end
      end
    end
  end
end
