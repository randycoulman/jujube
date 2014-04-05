require_relative "../test_helper"

class ScmTest < Minitest::Test
  include Jujube::Components

  def test_git
    expected = {"git" => {"url" => "URL", "branches" => ["master", "dev"], "wipe-workspace" => false}}
    actual = git(url: "URL", branches: %w{master dev}, wipe_workspace: false)
    assert_equal(expected, actual)
  end

  def test_store
    expected = {"store" =>
                    {
                        "script" => "SCRIPT",
                        "repository" => "REPO",
                        "pundles" => [{"package" => "PACKAGE"}, {"bundle" => "BUNDLE"}]
                    }
    }
    actual = store(script: "SCRIPT", repository: "REPO") do |pundles|
      pundles << package("PACKAGE") << bundle("BUNDLE")
    end
    assert_equal(expected, actual)
  end
end
