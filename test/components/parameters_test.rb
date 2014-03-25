require_relative "../test_helper"

class ParametersTest < Minitest::Test
  include Jujube::Components

  def test_label_expression_axis
    expected = {"axis" => {"type" => "label-expression", "name" => "arch", "values" => %w{i386 amd64}}}
    assert_equal(expected, label_expression(:arch, %w{i386 amd64}))
  end

  def test_slave_axis
    expected = {"axis" => {"type" => "slave", "name" => "arch", "values" => %w{i386 amd64}}}
    assert_equal(expected, slave(:arch, %w{i386 amd64}))
  end
end
