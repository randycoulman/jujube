require_relative "acceptance_test.rb"
require "minitest/autorun"

class UsageTest < AcceptanceTest

  def test_generates_single_job
    with_fixture("singleJob") do
      run_jujube("test.job")
      assert_exits_cleanly
      assert_file_exists("jobs.yml")
      assert_job_created("example")
      assert_match(/^\s*description: DESCRIPTION\s*$/m, File.read("jobs.yml"))
    end
  end

  def test_generates_multiple_jobs_from_single_file
    with_fixture("multipleJobs") do
      run_jujube("test.job")
      assert_exits_cleanly
      assert_file_exists("jobs.yml")
      assert_job_created("job1")
      assert_job_created("job2")
    end
  end

  def test_generates_jobs_from_multiple_files
    with_fixture("multipleFiles") do
      run_jujube("job1.job", "job2.job")
      assert_exits_cleanly
      assert_file_exists("jobs.yml")
      assert_job_created("job1")
      assert_job_created("job2")
    end
  end

  def test_generates_jobs_from_all_files_in_current_directory_by_default
    with_fixture("multipleFiles") do
      run_jujube
      assert_exits_cleanly
      assert_file_exists("jobs.yml")
      assert_job_created("job1")
      assert_job_created("job2")
    end
  end

  def test_generates_jobs_from_all_files_in_directory
    with_fixture("multipleFiles") do
      run_jujube(".")
      assert_exits_cleanly
      assert_file_exists("jobs.yml")
      assert_job_created("job1")
      assert_job_created("job2")
    end
  end

  def test_generates_jobs_from_all_recursive_files_in_directory
    with_fixture("multipleFiles") do
      run_jujube(".")
      assert_exits_cleanly
      assert_file_exists("jobs.yml")
      assert_job_created("job1")
      assert_job_created("job2")
    end
  end

  def test_places_output_in_current_directory_by_default
    with_fixture("multipleFiles") do
      run_jujube(".")
      assert_exits_cleanly
      assert_file_exists("jobs.yml")
      assert_job_created("job1")
      assert_job_created("job2")
    end
  end

  def test_places_output_in_specified_output_file
    with_fixture("singleJob") do
      run_jujube("test.job", "-o", "output/my_jobs.yml")
      assert_exits_cleanly
      assert_directory_exists("output")
      assert_file_exists("output/my_jobs.yml")
    end
  end

  private

  def assert_job_created(job, output_file = "jobs.yml")
    assert_match(/^- job:\s*\n    name: #{job}$/m, File.read(output_file))
  end
end
