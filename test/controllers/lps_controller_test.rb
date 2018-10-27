require 'test_helper'

class LpsControllerTest < ActionDispatch::IntegrationTest
  def setup
    @artist = Artist.create!(name: 'Name', description: 'Description.')
    @lp = @artist.lps.create!(name: 'LP', description: 'My record')
  end

  test 'should get index' do
    get lps_path
    assert_response :success
  end

  test 'should get new' do
    get new_artist_lp_path(@artist)
    assert_response :success
  end

  test 'should get edit' do
    get edit_artist_lp_path(@artist, @lp)
    assert_response :success
  end
end
