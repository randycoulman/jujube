module Jujube
  module Components

    # @!group Matrix Axes

    # Define a `label-expression` axis for a matrix job.
    #
    # See {http://ci.openstack.org/jenkins-job-builder/project_matrix.html}.
    #
    # @param name [Symbol, String] The name of the axis.
    # @param values [Array<String>] The values of the axis.
    def label_expression(name, values)
      axis(name, values, :label_expression)
    end

    # Define a `slave` axis for a matrix job.
    #
    # See {http://ci.openstack.org/jenkins-job-builder/project_matrix.html}.
    #
    # @param name [Symbol, String] The name of the axis.
    # @param values [Array<String>] The values of the axis.
    def slave(name, values)
      axis(name, values, :slave)
    end

    private

    # Define an axis for a matrix job.
    #
    # See {http://ci.openstack.org/jenkins-job-builder/project_matrix.html}.
    #
    # @param name [Symbol, String] The name of the axis.
    # @param values [Array<String>] The values of the axis.
    # @param type [Symbol, String] The axis type.
    def axis(name, values, type)
      options = {type: canonicalize(type), name: canonicalize(name), values: values}
      to_config("axis", options)
    end

    # @!endgroup
  end
end
