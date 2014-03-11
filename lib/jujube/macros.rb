module Jujube
  module Macros
    include Jujube::Utils

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

    def section(*section_names)
      section_names.each do |section_name|
        define_method section_name do
          config[section_name.to_s] ||= []
        end
      end
    end
  end
end
