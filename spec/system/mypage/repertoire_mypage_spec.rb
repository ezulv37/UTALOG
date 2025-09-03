require 'rails_helper'

RSpec.describe 'マイページ（レパートリータブ）', type: :system, js: true do
  let(:user){ create(:user) }
  let!(:song_a) { create(:song, user: user, title: "あいうえお", artist: "A", genre: "J-POP") }
  let!(:song_b) { create(:song, user: user, title: "さしすせそ", artist: "B", genre: "ロック") }
  let!(:song_c) { create(:song, user: user, title: "あかさたな", artist: "B", genre: "ロック") }
  let(:songs) { [song_a, song_b, song_c] }

  before do
    login_as_user(user)
    visit mypage_path
    click_on '楽曲レパートリー'
  end

  describe 'レパートリー検索' do
    it '曲名で検索すると、該当のレパートリーが表示される' do
      fill_in 'song_q', with: "あ"
      click_on '検索'

      within '.repertoire_grid' do
        expect(page).to have_content(song_a.title)
        expect(page).to have_content(song_a.artist)
        expect(page).to have_content(song_c.title)
        expect(page).to have_content(song_c.artist)
        expect(page).not_to have_content(song_b.title)
      end
    end

    it 'アーティスト名で検索すると、該当のレパートリーが表示される' do
      fill_in 'song_q', with: "B"
      click_on '検索'

      within '.repertoire_grid' do
        expect(page).to have_content(song_b.title)
        expect(page).to have_content(song_b.artist)
        expect(page).to have_content(song_c.title)
        expect(page).to have_content(song_c.artist)
        expect(page).not_to have_content(song_a.title)
        expect(page).not_to have_content(song_a.artist)
      end
    end

    it 'ジャンルにチェックを入れて検索すると、該当のレパートリーが表示される' do
      within '#repertoire' do
        check "ロック"
        click_on '検索'
      end

      within '.repertoire_grid' do
        expect(page).to have_content(song_b.title)
        expect(page).to have_content(song_b.artist)
        expect(page).to have_content(song_c.title)
        expect(page).to have_content(song_c.artist)
        expect(page).not_to have_content(song_a.title)
      end
    end
  end

  describe 'レパートリー情報' do
    it 'ログインユーザーのレパートリー（曲名、アーティスト名、ジャンル、キー、メモ、編集ボタン、削除ボタン）が表示される' do
      songs.each do |song|
        expect(page).to have_content(song_a.title)
        expect(page).to have_content(song_a.artist)
        expect(page).to have_content(song_a.genre)
        expect(page).to have_content(song_a.key_display)
        expect(page).to have_content(song_a.memo)
        expect(page).to have_link '編集'
        expect(page).to have_link '削除'
      end
    end

    it 'レパートリーが新しい順に表示される' do
      dates = all('.repertoire_item .created_at').map(&:text)
      expect(dates).to eq dates.sort.reverse
    end
  end

  describe 'レパートリーの編集・削除' do
    it '編集ボタンをクリックすると、レパートリー編集画面に遷移する', js: false do
      edit = find("a.repertoire_edit_button[href='#{edit_song_path(song_c)}']")
      edit.click
      expect(current_path).to eq(edit_song_path(song_c))
    end

    it '削除ボタンで削除できる' do
      accept_confirm do
        delete = find("a.repertoire_delete_button[href='#{song_path(song_c)}']")
        delete.click
      end
      expect(page).not_to have_content(song_c.title)
    end

    it '削除ボタンでキャンセルすると残る' do
      dismiss_confirm do
        delete = find("a.repertoire_delete_button[href='#{song_path(song_c)}']")
        delete.click
      end
      expect(page).to have_content(song_c.title)
      expect(page).to have_content(song_c.artist)
    end
  end
end
