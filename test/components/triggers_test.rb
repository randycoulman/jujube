require_relative "../test_helper"

class TriggersTest < Minitest::Test
  include Jujube::Components

  def test_gitlab
    expected = {
      "gitlab" => {
        "trigger-note" => false,
        "target-branch-regex" => "branches.*",
        "include-branches" => ["b1", "b2"]
      }
    }
    actual = gitlab(
      trigger_note: false,
      target_branch_regex: "branches.*",
      include_branches: %w{b1 b2}
    )
    assert_equal(expected, actual)
  end

  def test_pollscm
    expected = {
      "pollscm" => {
        "cron" => "CRON",
        "ignore-post-commit-hooks" => true
      }
    }
    actual = pollscm(cron: "CRON", ignore_post_commit_hooks: true)
    assert_equal(expected, actual)
  end

  def test_pollurl_with_no_content_checks
    expected = {"pollurl" =>
                    {"cron" => "CRON",
                     "urls" => [{"url" => "URL", "check-date" => true}]
                    }
    }
    actual = pollurl(cron: "CRON") do |urls|
      urls << url("URL", check_date: true)
    end
    assert_equal(expected, actual)
  end

  def test_pollurl_with_simple_content
    expected = {"pollurl" =>
                    {"urls" =>
                         [{"url" => "URL",
                           "check-content" => [{"simple" => true}]}]
                    }
    }
    actual = pollurl do |urls|
      urls << url("URL") do |content|
        content << simple
      end
    end
    assert_equal(expected, actual)
  end

  def test_pollurl_with_json_content
    expected = {"pollurl" =>
                    {"urls" =>
                         [{"url" => "URL",
                           "check-content" => [{"json" => %w{JSON_PATH1 JSON_PATH2}}]}]
                    }
    }
    actual = pollurl do |urls|
      urls << url("URL") do |content|
        content << json("JSON_PATH1", "JSON_PATH2")
      end
    end
    assert_equal(expected, actual)
  end

  def test_pollurl_with_xml_content
    expected = {"pollurl" =>
                    {"urls" =>
                         [{"url" => "URL",
                           "check-content" => [{"xml" => %w{XPATH1 XPATH2}}]}]
                    }
    }
    actual = pollurl do |urls|
      urls << url("URL") do |content|
        content << xml("XPATH1", "XPATH2")
      end
    end
    assert_equal(expected, actual)
  end

  def test_pollurl_with_text_content
    expected = {"pollurl" =>
                    {"urls" =>
                         [{"url" => "URL",
                           "check-content" => [{"text" => %w{REGEX1 REGEX2}}]}]
                    }
    }
    actual = pollurl do |urls|
      urls << url("URL") do |content|
        content << text("REGEX1", "REGEX2")
      end
    end
    assert_equal(expected, actual)
  end

  def test_reverse
    expected = { "reverse" => { "jobs" => "foo, bar", "result" => "success" } }
    actual = reverse(jobs: %w{foo bar}, result: "success")
    assert_equal(expected, actual)
  end
end
