module Jujube
  module Components
    def label_expression(name, values)
      axis(name, values, :label_expression)
    end

    def slave(name, values)
      axis(name, values, :slave)
    end

    def axis(name, values, type)
      options = {type: canonicalize(type), name: canonicalize(name), values: values}
      to_config("axis", options)
    end
  end
end
