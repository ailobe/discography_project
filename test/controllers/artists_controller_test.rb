require 'test_helper'

class ArtistsControllerTest < ActionDispatch::IntegrationTest
  def setup
    @artist = Artist.create!(name: 'Name', description: 'Description.')
  end

  test 'should get index' do
    get artists_path
    assert_response :success
  end

  test 'should get new' do
    get new_artist_path
    assert_response :success
  end

  test 'should get edit' do
    get edit_artist_path(@artist)
    assert_response :success
  end

  test 'should get artist records page' do
    get artist_lps_path(@artist)
    assert_response :success
  end
end
