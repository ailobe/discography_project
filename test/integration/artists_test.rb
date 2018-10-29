require 'test_helper'

class ArtistsTest < ActionDispatch::IntegrationTest
  def setup
    @artist = Artist.create!(name: 'Name', description: 'Description.')
  end

  test 'Invalid new artist submission' do
    get new_artist_path
    assert_no_difference 'Artist.count' do
      post artists_path, params: { artist: { name: '', description: '' } }
    end
    assert_template 'artists/new'
    assert_select 'article.message.is-danger'
  end

  test 'Valid new artist submission' do
    get new_artist_path
    assert_difference 'Artist.count', 1 do
      post artists_path, params: { artist: { name: 'Artist',
                                             description: 'My bio' } }
    end
    artist = assigns(:artist)
    assert_redirected_to artist
    follow_redirect!
    assert_template 'artists/show'
    assert_match artist.name, response.body
    assert_match artist.description, response.body
    assert_match artist.lps.count.to_s, response.body
  end

  test 'Unsuccesful edit' do
    get edit_artist_path(@artist)
    patch artist_path(@artist), params: { artist: { name: '',
                                                    description: '' } }
    assert_template 'artists/edit'
    assert_select 'article.message.is-danger'
  end

  test 'Succesful edit' do
    get edit_artist_path(@artist)
    patch artist_path(@artist), params: { artist: { name: 'Different',
                                                    description: 'Different' } }
    artist = assigns(:artist)
    assert_redirected_to @artist
    follow_redirect!
    assert_match artist.name, response.body
    assert_match artist.description, response.body
  end

  test 'Delete artist' do
    get artist_path(@artist)
    assert_select 'a[href=?]', artist_path(@artist), text: 'Delete'
    assert_difference 'Artist.count', -1 do
      delete artist_path(@artist)
    end
    assert_not flash.empty?
    assert_redirected_to artists_path
  end
end
