require_relative "../test_helper"

class PublishersTest < Minitest::Test
  include Jujube::Components

  def test_archive
    expected = {"archive" => {"artifacts" => "ARTIFACTS", "latest-only" => true, "allow-empty" => true}}
    assert_equal(expected, archive(artifacts: "ARTIFACTS", latest_only: true, allow_empty: true))
  end

  def test_cppcheck
    expected = {"cppcheck" => {"pattern" => "PATTERN"}}
    assert_equal(expected, cppcheck(pattern: "PATTERN"))
  end

  def test_email_ext
    assert_equal("email-ext", email_ext)
  end

  def test_email_ext_with_recipients
    expected = {"email-ext" => {"recipients" => "fred, barney"}}
    assert_equal(expected, email_ext(recipients: %w{fred barney}.join(", ")))
  end

  def test_fitnesse
    expected = {"fitnesse" => {"results" => "RESULTS"}}
    assert_equal(expected, fitnesse(results: "RESULTS"))
  end

  def test_ircbot
    expected = {"ircbot" => {"notify-start" => true}}
    assert_equal(expected, ircbot(notify_start: true))
  end

  def test_junit
    expected = {"junit" => {"results" => "RESULTS", "keep-long-stdio" => false}}
    assert_equal(expected, junit(results: "RESULTS", keep_long_stdio: false))
  end

  def test_trigger
    expected = {"trigger" => {"project" => "PROJECT"}}
    assert_equal(expected, trigger(project: "PROJECT"))
  end

  def test_trigger_parameterized_builds
    expected = {"trigger-parameterized-builds" => [
        {"project" => ["PROJECT1", "PROJECT2"], "condition" => "UNSTABLE"}
    ]}
    actual = trigger_parameterized_builds do |builds|
      builds << build(project: %w[PROJECT1 PROJECT2], condition: "UNSTABLE")
    end
    assert_equal(expected, actual)
  end

  def test_trigger_parameterized_builds_formats_single_predefined_parameter
    expected = {"trigger-parameterized-builds" => [
        {"predefined-parameters" => "param=value"}
    ]}
    actual = trigger_parameterized_builds do |builds|
      builds << build(predefined_parameters: {param: 'value'})
    end
    assert_equal(expected, actual)
  end

  def test_trigger_parameterized_builds_formats_multiiple_predefined_parameters
    expected = {"trigger-parameterized-builds" => [
        {"predefined-parameters" => "param1=value1\nparam2=value2\n"}
    ]}
    actual = trigger_parameterized_builds do |builds|
      builds << build(predefined_parameters: {param1: 'value1', param2: 'value2'})
    end
    assert_equal(expected, actual)
  end

  def test_trigger_parameterized_builds_formats_boolean_parameters
    expected = {"trigger-parameterized-builds" => [
        {"boolean-parameters" => {"param_1" => true, "param_2" => false}}
    ]}
    actual = trigger_parameterized_builds do |builds|
      builds << build(boolean_parameters: {param_1: true, param_2: false})
    end
    assert_equal(expected, actual)
  end

  def test_trigger_parameterized_builds_formats_git_revision_as_boolean
    expected = {"trigger-parameterized-builds" => [
        {"git-revision" => true}
    ]}
    actual = trigger_parameterized_builds do |builds|
      builds << build(git_revision: true)
    end
    assert_equal(expected, actual)
  end

  def test_trigger_parameterized_builds_formats_git_revision_as_nested_hash
    expected = {"trigger-parameterized-builds" => [
        {"git-revision" => {"combine-queued-commits" => true}}
    ]}
    actual = trigger_parameterized_builds do |builds|
      builds << build(git_revision: {combine_queued_commits: true})
    end
    assert_equal(expected, actual)
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
end
