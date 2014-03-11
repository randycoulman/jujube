require_relative "test_helper"

class BuildersTest < Minitest::Test
  include Jujube::Components

  def test_shell
    expected = {'shell' => 'COMMAND'}
    assert_equal(expected, shell('COMMAND'))
  end
end
