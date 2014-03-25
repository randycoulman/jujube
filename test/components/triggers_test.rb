require_relative "../test_helper"

class TriggersTest < Minitest::Test
  include Jujube::Components

  def test_pollscm
    assert_equal({'pollscm' => 'INTERVAL'}, pollscm('INTERVAL'))
  end
end
