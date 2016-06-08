require_relative "../test_helper"

class ParametersTest < Minitest::Test
  include Jujube::Components

  def test_validating_string
    expected = {"validating-string" => {"name" => "NAME", "regex" => "REGEX", "msg" => "MESSAGE" }}
    assert_equal(expected, validating_string(name: "NAME", regex: "REGEX", msg: "MESSAGE"))
  end
end
