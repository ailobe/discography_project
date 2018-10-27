require 'test_helper'

class ArtistTest < ActiveSupport::TestCase
  def setup
    @artist = Artist.new(name: 'Name', description: 'Description.')
  end

  test 'should be valid' do
    assert  @artist.valid?
  end

  test 'name should be present' do
    @artist.name = '  '
    assert_not @artist.valid?
  end

  test 'name should not be too long' do
    @artist.name = 'a' * 51
    assert_not @artist.valid?
  end

  test 'description should be present' do
    @artist.description = '  '
    assert_not @artist.valid?
  end

  test 'description should not be too long' do
    @artist.description = 'a' * 256
    assert_not @artist.valid?
  end

  test 'associated records should be destroyed' do
    @artist.save
    @artist.lps.create!(name: 'LP', description: 'My record')
    assert_difference 'Lp.count', -1 do
      @artist.destroy
    end
  end
end
