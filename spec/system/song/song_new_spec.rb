require 'rails_helper'

RSpec.describe 'レパートリー登録', type: :system do
  let(:user){ create(:user) }
  let(:song) { build(:song) }

  before do
    login_as_user(user)
    visit new_song_path
  end

  describe "楽曲登録が成功する場合" do
    it '楽曲登録が成功する（登録後はマイページに自動遷移）' do
      fill_in '曲名', with: song.title
      fill_in 'アーティスト', with: song.artist
      choose "song_genre_#{song.genre.parameterize}"
      fill_in 'キー', with: song.key
      fill_in 'メモ', with: song.memo
      click_button '保存'
      expect(page).to have_current_path("#{mypage_path}?tab=repertoire")
      expect(page).to have_content 'レパートリー楽曲を新規登録しました'

      within '#repertoire' do
        within '.repertoire_grid' do
          expect(page).to have_content song.title
          expect(page).to have_content song.artist
          expect(page).to have_content song.genre
          expect(page).to have_content song.key_display
          expect(page).to have_content song.memo
        end
      end

      within '.user_stats' do
        songs_stat = find('.stat_item', text: '楽曲数').find('.stat_value')
        expect(Integer(songs_stat.text, 10)).to be > 0
      end
    end

    it 'キーとメモが空欄でも楽曲登録が成功する（登録後はマイページに自動遷移）' do
      fill_in '曲名', with: song.title
      fill_in 'アーティスト', with: song.artist
      choose "song_genre_#{song.genre.parameterize}"
      fill_in 'キー', with: ''
      fill_in 'メモ', with: ''
      click_button '保存'
      expect(page).to have_current_path("#{mypage_path}?tab=repertoire")
      expect(page).to have_content 'レパートリー楽曲を新規登録しました'

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

      within '.user_stats' do
        songs_stat = find('.stat_item', text: '楽曲数').find('.stat_value')
        expect(Integer(songs_stat.text, 10)).to be > 0
      end
    end
  end

  describe "楽曲登録が失敗する場合" do
    it '必須項目を空で送信するとエラーが出る' do
      click_button '保存'
      expect(page).to have_current_path(songs_path)
      expect(page).to have_content '曲名を入力してください'
      expect(page).to have_content 'アーティスト名を入力してください'
      expect(page).to have_content 'ジャンルを入力してください'
    end

    it 'メモの文字数が200文字を文字を超えるとエラーが出る' do
      fill_in '曲名', with: song.title
      fill_in 'アーティスト', with: song.artist
      choose "song_genre_#{song.genre.parameterize}"
      fill_in 'キー', with: song.key
      fill_in 'メモ', with: 'a' * 201
      click_button '保存'
      expect(page).to have_current_path(songs_path)
      expect(page).to have_content 'メモは200文字以内で入力してください'
    end
  end

  describe "キャンセルする（登録しない）場合" do
    it 'キャンセルリンクを押すとマイページに遷移する' do
      click_on 'キャンセル'
      expect(current_path).to eq mypage_path
    end
  end
end
