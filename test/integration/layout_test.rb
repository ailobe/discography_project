require 'test_helper'

class LayoutTest < ActionDispatch::IntegrationTest
  def setup
    @artist = Artist.create!(name: 'Name', description: 'Description.')
    @lp = @artist.lps.create!(name: 'LP', description: 'My record')
  end

  test 'layout links' do
    get root_path
    assert_template 'welcome/home'
    assert_select "a[href=?]", root_path
    assert_select "a[href=?]", artists_path
    assert_select "a[href=?]", lps_path
    get artists_path
    assert_select "a[href=?]", new_artist_path
    assert_select "a[href=?]", artist_path(@artist)
    get artist_path(@artist)
    assert_select "a[href=?]", edit_artist_path(@artist)
    assert_select 'a[href=?]', artist_path(@artist), text: 'Delete'
    assert_select "a[href=?]", artist_lps_path(@artist)
    get artist_lps_path(@artist)
    assert_select "a[href=?]", new_artist_lp_path(@artist)
    assert_select "a[href=?]", artist_lp_path(@artist, @lp)
    get artist_lp_path(@artist, @lp)
    assert_select "a[href=?]", edit_artist_lp_path(@artist, @lp)
    assert_select 'a[href=?]', artist_lp_path(@artist, @lp), text: 'Delete'
    get lps_path
    assert_select "a[href=?]", artist_lp_path(@artist, @lp)
    assert_select "a[href=?]", artist_lps_path(@artist)
  end
end
