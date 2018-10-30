require 'test_helper'

class LpTest < ActiveSupport::TestCase
  def setup
    @artist = Artist.new(name: 'Name', description: 'Description.')
    @lp = @artist.lps.build(name: 'LP', description: 'My record')
  end

  test 'should be valid' do
    assert @lp.valid?
  end

  test 'name should be present' do
    @lp.name = '  '
    assert_not @lp.valid?
  end

  test 'name should not be too long' do
    @lp.name = 'a' * 71
    assert_not @lp.valid?
  end

  test 'description should be present' do
    @lp.description = '  '
    assert_not @lp.valid?
  end

  test 'description should not be too long' do
    @lp.description = 'a' * 301
    assert_not @lp.valid?
  end
end
