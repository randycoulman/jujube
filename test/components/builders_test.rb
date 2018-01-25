require_relative "../test_helper"

class BuildersTest < Minitest::Test
  include Jujube::Components

  def test_shell
    expected = {'shell' => 'COMMAND'}
    assert_equal(expected, shell('COMMAND'))
  end

  def test_copyartifact
    result = copyartifact(
      project: 'upstream-project',
      which_build: 'last-successful',
      target: 'dest_dir',
      do_not_fingerprint: true
    )
    expected = {
      'copyartifact' => {
        'project' => 'upstream-project',
        'which-build' => 'last-successful',
        'target' => 'dest_dir',
        'do-not-fingerprint' => true
      }
    }
    assert_equal(expected, result)
  end
end
