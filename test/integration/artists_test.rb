require 'test_helper'

class ArtistsTest < ActionDispatch::IntegrationTest
  def setup
    @artist = Artist.create!(name: 'Name', description: 'Description.')
  end

  test 'profile display' do
    get artist_path(@artist)
    assert_template 'artists/show'
    assert_select 'p.heading', text: 'Artist profile'
    assert_select 'p.title', text: @artist.name
    assert_match @artist.description, response.body
    assert_match @artist.lps.count.to_s, response.body
  end

  test 'artist interface' do
    get artists_path
    # Invalid new artist submission
    assert_no_difference 'Artist.count' do
      post artists_path, params: { artist: { name: '', description: '' } }
    end
    # assert_not flash.empty?
    # Valid new artist submission
    name = 'Just'
    description = 'Me, Myself and I'
    assert_difference 'Artist.count', 1 do
      post artists_path, params: { artist: { name: name,
                                            description: description } }
    end
    # assert_not flash.empty?
    follow_redirect!
    assert_match description, response.body
    artist = assigns(:artist)
    # Unsuccesful edit
    get edit_artist_path(artist)
    assert_template 'artists/edit'
    patch artist_path(artist), params: { artist: { name: '',
                                                  description: '' } }
    assert_template 'artists/edit'
    #assert_select  "div.alert", 'The form contains 2 errors.'
    # Succesful edit
    patch artist_path(artist), params: { artist: { name: 'Different',
                                                    description: 'Different' } }
    #assert_not flash.empty?
    assert_redirected_to artist
    follow_redirect!
    # Delete artist
    assert_select 'a', text: 'Delete'
    assert_difference 'Artist.count', -1 do
      delete artist_path(artist)
    end
  end
end
