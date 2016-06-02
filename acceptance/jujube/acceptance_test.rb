require "minitest/autorun"
require "open3"
require "pathname"
require "tmpdir"

class AcceptanceTest < Minitest::Test
  def with_fixture(fixture_name)
    fixture = fixture_root.join(fixture_name)
    Dir.mktmpdir do |temp_directory|
      temp_directory = Pathname.new(temp_directory)
      FileUtils.cp_r(fixture, temp_directory, preserve: true)
      working = temp_directory.join(fixture_name)
      Dir.chdir(working) do
        yield
      end
    end
  end

  def run_jujube(*arguments)
    jujube = bin_directory.join("jujube").to_s
    @output, @error_output, @status = Open3.capture3(jujube, *arguments)
  end

  def assert_exits_cleanly
    assert_equal(0, @status.exitstatus, @error_output)
  end

  def assert_file_exists(filename)
    assert(File.exist?(filename), "File #{filename} does not exist")
  end

  def assert_directory_exists(filename)
    assert(Dir.exist?(filename), "Directory #{filename} does not exist")
  end

  def fixture_root
    acceptance_root.join("fixtures")
  end

  def bin_directory
    acceptance_root.join("..", "bin")
  end

  def acceptance_root
    Pathname.new(__FILE__).dirname.join("..").expand_path
  end
end
