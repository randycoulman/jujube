module Jujube
  module Components

    # Helper methods for creating matrix axes components.
    module Axes
      extend Macros

      # Specify a `label-expression` axis for a matrix job.
      #
      # See {https://jenkins-job-builder.readthedocs.io/en/latest/project_matrix.html}.
      #
      # @param name [Symbol, String] The name of the axis.
      # @param values [Array<String>] The values of the axis.
      # @return [Hash] The specification for the axis.
      def label_expression(name, values)
        axis(name, values, :label_expression)
      end

      # Specify a `slave` axis for a matrix job.
      #
      # See {https://jenkins-job-builder.readthedocs.io/en/latest/project_matrix.html}.
      #
      # @param name [Symbol, String] The name of the axis.
      # @param values [Array<String>] The values of the axis.
      # @return [Hash] The specification for the axis.
      def slave(name, values)
        axis(name, values, :slave)
      end

      private

      # Specify an axis for a matrix job.
      #
      # See {https://jenkins-job-builder.readthedocs.io/en/latest/project_matrix.html}.
      #
      # @param name [Symbol, String] The name of the axis.
      # @param values [Array<String>] The values of the axis.
      # @param type [Symbol, String] The axis type.
      # @return [Hash] The specification for the axis.
      def axis(name, values, type)
        options = {type: canonicalize(type), name: canonicalize(name), values: values}
        to_config("axis", options)
      end
    end
  end
end
