require_relative "../test_helper"

class WrappersTest < Minitest::Test
  include Jujube::Components

  def test_timestamps
    assert_equal('timestamps', timestamps)
  end

  def test_timeout
    expected = {'timeout' => {'type' => 'elastic', 'fail' => true}}
    assert_equal(expected, timeout(type: 'elastic', fail: true))
  end

  def test_canonicalizes_timeout_keys
    expected = {'timeout' => {'elastic-percentage' => 150, 'elastic-default-timeout' => 3}}
    assert_equal(expected, timeout(elastic_percentage: 150, elastic_default_timeout: 3))
  end
end
