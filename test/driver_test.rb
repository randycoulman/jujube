require_relative "test_helper"
require "flexmock/minitest"

class DriverTest < Minitest::Test
  def setup
    @jobs = [Object.new, Object.new]
    @loader = flexmock("loader", :on, Jujube::JobLoader)
    @generator = flexmock("generator", :on, Jujube::JobFileGenerator)
    @driver = Jujube::Driver.new(@loader, @generator)
  end

  def test_loads_all_files_in_current_directory_by_default
    @driver.run([])
    assert_spy_called(@loader, :load_jobs, Pathname.getwd)
  end

  def test_loads_single_file
    @driver.run(%w{test.job})
    assert_spy_called(@loader, :load_jobs, Pathname.new("test.job"))
  end

  def test_loads_multiple_files
    @driver.run(%w{job1.job job2.job})
    assert_spy_called(@loader, :load_jobs, Pathname.new("job1.job"), Pathname.new("job2.job"))
  end

  def test_generates_job_files
    @loader.should_receive(:load_jobs => @jobs)
    @driver.run([])
    assert_spy_called(@generator, :generate, @jobs, Pathname.new("jobs.yml"))
  end

  def test_generates_into_output_file
    @loader.should_receive(:load_jobs => @jobs)
    @driver.run(%w{-o OUTPUT_FILE})
    assert_spy_called(@generator, :generate, @jobs, Pathname.new("OUTPUT_FILE"))
  end

  def test_handles_mix_of_arguments
    @loader.should_receive(:load_jobs => @jobs)
    @driver.run(%w{job1.job job2.job -o OUTPUT_FILE})
    assert_spy_called(@loader, :load_jobs, Pathname.new("job1.job"), Pathname.new("job2.job"))
    assert_spy_called(@generator, :generate, @jobs, Pathname.new("OUTPUT_FILE"))
  end
end
