require_relative "test_helper"

class JobTest < Minitest::Test
  include Jujube

  def setup
    @job = Job.new("testJob")
  end

  def test_knows_name
    assert_equal("testJob", @job.name)
  end

  def test_includes_name
    assert_yaml_matches("name: testJob")
  end

  def test_includes_description
    @job.description = "DESCRIPTION"
    assert_yaml_matches("description: DESCRIPTION")
  end

  def test_includes_node
    @job.node = "NODE"
    assert_yaml_matches("node: NODE")
  end

  def test_includes_block_upstream
    @job.block_upstream = true
    assert_yaml_matches("block-upstream: true")
  end

  def test_includes_block_downstream
    @job.block_downstream = true
    assert_yaml_matches("block-downstream: true")
  end

  def test_includes_quiet_period
    @job.quiet_period = 42
    assert_yaml_matches("quiet-period: 42")
  end

  def test_includes_disabled
    @job.disabled = true
    assert_yaml_matches("disabled: true")
  end

  def test_includes_single_item_section
    @job.triggers << "TRIGGER"
    assert_yaml_matches("triggers:\s*\n  - TRIGGER")
  end

  def test_includes_multi_item_section
    @job.wrappers << "FIRST" << "SECOND"
    assert_yaml_matches("wrappers:\s*\n  - FIRST\n  - SECOND")
  end

  def test_infers_matrix_project_type_when_axes_specified
    @job.axes << "AXIS"
    assert_yaml_matches("project-type: matrix")
  end

  def test_renames_scms_to_scm
    @job.scm << "SCM"
    assert_yaml_matches("scm:\s*\n  - SCM")
  end

  def test_self_registers_with_active_registry
    job1 = nil
    job2 = nil
    jobs = Job.all_defined_during do
      job1 = Job.new("job1")
      job2 = Job.new("job2")
    end
    assert_equal([job1, job2], jobs)
  end

  private

  def assert_yaml_matches(snippet)
    expected = %r{^job:\s*$.*^  #{snippet}$}m
    assert_match(expected, @job.to_yaml)
  end
end
