require_relative "../test_helper"

class ScmsTest < Minitest::Test
  include Jujube::Components

  def test_git
    expected = {"git" => {"url" => "URL", "branches" => ["master", "dev"], "wipe-workspace" => false}}
    actual = git(url: "URL", branches: %w{master dev}, wipe_workspace: false)
    assert_equal(expected, actual)
  end
end
