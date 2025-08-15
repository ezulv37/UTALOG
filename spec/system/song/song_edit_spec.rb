require 'rails_helper'

RSpec.describe 'レパートリー編集', type: :system do
  let(:user){ create(:user) }
  let(:song) { create(:song, user: user) }

  before do
    login_as_user(user)
    visit edit_song_path(song)
  end

  describe "楽曲編集が成功する場合" do
    it '既存のレパートリー情報が表示されている' do
      expect(page).to have_field('曲名', with: song.title)
      expect(page).to have_field('アーティスト', with: song.artist)
      expect(page).to have_checked_field("song_genre_#{song.genre.parameterize}")
      expect(page).to have_field('キー', with: song.key)
      expect(page).to have_field('メモ', with: song.memo)
    end

    it '楽曲編集が成功する（編集後はマイページに自動遷移）' do
      fill_in '曲名', with: 'new_song_title'
      fill_in 'アーティスト', with: 'new_song_artist'
      fill_in 'キー', with: 1
      fill_in 'メモ', with: 'new_song_memo'
      click_button '保存'
      expect(page).to have_current_path("#{mypage_path}?tab=repertoire")
      expect(page).to have_content 'レパートリー楽曲を更新しました'

      within '#repertoire' do
        within '.repertoire_grid' do
          expect(page).to have_content 'new_song_title'
          expect(page).to have_content 'new_song_artist'
          expect(page).to have_content song.genre
          expect(page).to have_content song.key_display
          expect(page).to have_content 'new_song_memo'
        end
      end
    end

    it 'キーとメモが空欄でも楽曲編集が成功する（編集後はマイページに自動遷移）' do
      fill_in 'キー', with: ''
      fill_in 'メモ', with: ''
      click_button '保存'
      expect(page).to have_current_path("#{mypage_path}?tab=repertoire")
      expect(page).to have_content 'レパートリー楽曲を更新しました'

      within '#repertoire' do
        within '.repertoire_grid' do
          expect(page).to have_content song.title
          expect(page).to have_content song.artist
          expect(page).to have_content song.genre
          expect(page).to have_content song.key_display

          within '.repertoire_memo' do
            expect(page.text).to eq ''
          end
        end
      end
    end
  end

  describe "楽曲編集が失敗する場合" do
    it '必須項目を空で送信するとエラーが出る' do
      fill_in '曲名', with: ''
      fill_in 'アーティスト', with: ''
      click_button '保存'
      expect(page).to have_current_path(song_path(song))
      expect(page).to have_content '曲名を入力してください'
      expect(page).to have_content 'アーティスト名を入力してください'
    end

    it 'メモの文字数が200文字を文字を超えるとエラーが出る' do
      fill_in 'メモ', with: 'a' * 201
      click_button '保存'
      expect(page).to have_current_path(song_path(song))
      expect(page).to have_content 'メモは200文字以内で入力してください'
    end
  end

  describe "キャンセルする（編集しない）場合" do
    it 'キャンセルリンクを押すとマイページに遷移する' do
      click_on 'キャンセル'
      expect(current_path).to eq mypage_path
    end
  end
end
