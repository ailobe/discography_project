require 'test_helper'

class LpsTest < ActionDispatch::IntegrationTest
  def setup
    @artist = Artist.create!(name: 'Name', description: 'Description.')
    @lp = @artist.lps.create!(name: 'LP', description: 'My record')
  end

  test 'Invalid new LP submission' do
    get new_artist_lp_path(@artist)
    assert_no_difference 'Lp.count' do
      post artist_lps_path, params: { lp: { name: '', description: '' } }
    end
    assert_template 'lps/new'
    assert_select 'article.message.is-danger'
  end

  test 'Valid new LP submission' do
    get new_artist_lp_path(@artist)
    assert_difference 'Lp.count', 1 do
      post artist_lps_path(@artist), params: { lp: { name: 'Record',
                                            description: 'Awesome' } }
    end
    lp = assigns(:lp)
    artist = Artist.find(lp.artist_id)
    assert_redirected_to artist_lp_path(artist, lp)
    follow_redirect!
    assert_template 'lps/show'
    assert_match lp.name, response.body
    assert_match lp.description, response.body
    assert_match artist.name, response.body
  end

  test 'Unsuccesful edit' do
    get edit_artist_lp_path(@artist, @lp)
    patch artist_lp_path(@artist, @lp), params: { lp: { name: '',
                                                        description: '' } }
    assert_template 'lps/edit'
    assert_select 'article.message.is-danger'
  end

  test 'Succesful edit' do
    get edit_artist_lp_path(@artist, @lp)
    patch artist_lp_path(@artist, @lp),
          params: { lp: { name: 'Dif', description: 'ferent' } }
    lp = assigns(:lp)
    assert_redirected_to artist_lp_path(lp.artist_id, lp)
    follow_redirect!
    assert_template 'lps/show'
    assert_match lp.name, response.body
    assert_match lp.description, response.body
  end

  test 'Delete LP' do
    get artist_lp_path(@artist, @lp)
    assert_select 'a[href=?]', artist_lp_path(@artist, @lp), text: 'Delete'
    assert_difference 'Lp.count', -1 do
      delete artist_lp_path(@artist, @lp)
    end
    assert_not flash.empty?
    assert_redirected_to artist_lps_path(@artist)
  end
end
