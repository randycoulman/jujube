require_relative "acceptance_test.rb"
require "minitest/autorun"
require "yaml"

class EndToEndTest < AcceptanceTest
  def test_end_to_end
    with_fixture("endToEnd") do
      run_jujube("endToEnd.job")
      assert_exits_cleanly
      assert_equal(YAML.load_file("expected.yml"), YAML.load_file("jobs.yml"))
    end
  end
end
