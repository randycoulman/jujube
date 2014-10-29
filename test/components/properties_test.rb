require_relative "../test_helper"

class PropertiesTest < Minitest::Test
  include Jujube::Components

  def test_throttle
    expected = {"throttle" => {"max-total" => 42, "option" => "category", "categories" => %w{cat1 cat2}}}
    assert_equal(expected, throttle(max_total: 42, option: "category", categories: %w{cat1 cat2}))
  end
end
