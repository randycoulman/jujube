require_relative "../test_helper"

class TriggersTest < Minitest::Test
  include Jujube::Components

  def test_reverse
    expected = { 'reverse' => { 'jobs' => 'foo,bar', 'result' => 'success' } }
    actual = reverse(watch_projects: %w(foo bar), trigger_on: 'success')
    assert_equal(expected, actual)
  end

  def test_pollscm
    assert_equal({"pollscm" => "INTERVAL"}, pollscm("INTERVAL"))
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
end
