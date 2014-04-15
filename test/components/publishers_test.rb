require_relative "../test_helper"

class PublishersTest < Minitest::Test
  include Jujube::Components

  def test_email_ext
    assert_equal("email-ext", email_ext)
  end

  def test_email_ext_with_recipients
    expected = {"email-ext" => {"recipients" => "fred, barney"}}
    assert_equal(expected, email_ext(recipients: %w{fred barney}.join(", ")))
  end

  def test_ircbot
    expected = {"ircbot" => {"notify-start" => true}}
    assert_equal(expected, ircbot(notify_start: true))
  end

  def test_junit
    expected = {"junit" => {"results" => "RESULTS", "keep-long-stdio" => false}}
    assert_equal(expected, junit(results: "RESULTS", keep_long_stdio: false))
  end

  def test_archive
    expected = {"archive" => {"artifacts" => "ARTIFACTS", "latest-only" => true, "allow-empty" => true}}
    assert_equal(expected, archive(artifacts: "ARTIFACTS", latest_only: true, allow_empty: true))
  end

  def test_cppcheck
    expected = {"cppcheck" => {"pattern" => "PATTERN"}}
    assert_equal(expected, cppcheck(pattern: "PATTERN"))
  end

  def test_xunit
    expected = {"xunit" =>
                    {"types" =>
                         [{"unittest" => {"pattern" => "PATTERN", "deleteoutput" => false}}]
                    }
    }
    actual = xunit do |types|
      types << unittest(pattern: "PATTERN", deleteoutput: false)
    end
    assert_equal(expected, actual)
  end

  def test_trigger
    expected = {"trigger" => {"project" => "PROJECT"}}
    assert_equal(expected, trigger(project: "PROJECT"))
  end

  def test_fitnesse
    expected = {"fitnesse" => {"results" => "RESULTS"}}
    assert_equal(expected, fitnesse(results: "RESULTS"))
  end
end
