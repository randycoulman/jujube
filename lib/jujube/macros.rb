module Jujube

  # Macros for defining methods that make it easier to specify the parts
  # a job.
  module Macros
    include Jujube::Utils

    # A macro that defines an attribute of a job.
    # It generates a reader and a writer for the attribute.
    #
    # @param attribute_name [Symbol] The name of the attribute.
    def attribute(attribute_name)
      canonical_name = canonicalize(attribute_name)

      define_method attribute_name do
        config[canonical_name]
      end

      define_method "#{attribute_name}=".to_sym do |value|
        config[canonical_name] = value
      end
    end

    # A macro that defines a section of a job.
    # It generates a method that returns the `Array` of components
    # in that section.
    #
    # @param section_name [Symbol] The name of the section.
    def section(section_name)
      define_method section_name do
        config[section_name.to_s] ||= []
      end
    end
  end
end
