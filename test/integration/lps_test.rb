require 'test_helper'

class LpsTest < ActionDispatch::IntegrationTest
  def setup
    @artist = Artist.create!(name: 'Name', description: 'Description.')
    @lp = @artist.lps.create!(name: 'LP', description: 'My record')
  end

  test 'lp show' do
    get artist_lp_path(@artist, @lp)
    assert_template 'lps/show'
    assert_select 'p.heading', text: 'LP RECORD'
    assert_select 'p.title', text: @lp.name
    assert_match @lp.description, response.body
    assert_select 'a', text: 'Edit'
    assert_select 'a', text: 'Delete'
  end

  test 'artist interface' do
    get new_artist_lp_path(@artist)
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
