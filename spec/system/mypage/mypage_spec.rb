require 'rails_helper'

RSpec.describe 'マイページ', type: :system do
  let(:user){ create(:user) }
  let!(:song) { create(:song, user: user) }
  let!(:practice) { create(:practice, user: user, score: 99) }

  before do
    login_as_user(user)
    visit mypage_path
  end

  describe 'ユーザー情報' do
    it 'アイコン、ユーザー名、練習回数、楽曲数、平均スコア、練習するボタン、レパートリー追加ボタンが表示されている' do
      within '.user_info' do
        image_tag = find(".mypage_icon_image")
        expect(image_tag[:src]).to match(/default_icon.*\.png/)
        expect(page).to have_content user.name
        expect(page).to have_content user.practices.count
        expect(page).to have_content user.songs.count
        expect(page).to have_content "99.0"
        expect(page).to have_link '練習する', href: new_practice_path
        expect(page).to have_link 'レパートリー追加', href: new_song_path
      end
    end

    it '平均スコア：小数点第2位が四捨五入され、小数点第1位まで表示される' do
      create(:practice, user: user, score: 65)
      create(:practice, user: user, score: 66)
      visit mypage_path

      within '.user_info' do
        expect(page).to have_content "76.7"
      end
    end

    it '「練習する」ボタンを押すと練習ログ登録画面に遷移する' do
      within '.user_info' do
        click_on '練習する'
      end

      expect(page).to have_current_path new_practice_path
    end

    it '「レパートリー追加」ボタンを押すとレパートリー登録画面に遷移する' do
      click_on 'レパートリー追加'
      expect(page).to have_current_path new_song_path
    end
  end

  describe 'タブナビゲーション', js: true do
    it '練習ログとレパートリーのタブが表示されている' do
      within '.tab_nav' do
        expect(page).to have_content('レパートリー')
        expect(page).to have_content('練習ログ')
      end
    end

    it 'デフォルトでは練習ログタブが開かれている' do
      expect(page).to have_content(practice.title)
      expect(page).not_to have_css(".genre_checkboxes")

      within '.practice_list' do
        expect(page).to have_css('.practice_item')
      end
    end

    it '練習ログのタブを押すと検索フォームと練習ログ一覧が開く' do
      click_on '楽曲レパートリー'
      expect(page).to have_content(song.title)

      click_on '練習ログ'

      within '.search_input_container' do
        expect(page).to have_field(nil, name: 'practice_q')
        expect(page).to have_css('.search_button')
      end

      within '.practice_list' do
        expect(page).to have_css('.practice_item')
      end
    end

    it 'レパートリータブを押すと検索フォームとジャンル検索ボックス、レパートリー一覧が開く' do
      click_on '楽曲レパートリー'

      within '.search_input_container' do
        expect(page).to have_field(nil, name: 'song_q')
        expect(page).to have_css('.search_button')
      end

      within ".genre_checkboxes" do
        expect(page).to have_unchecked_field('J-POP')
        expect(page).to have_unchecked_field('ロック')
        expect(page).to have_unchecked_field('バラード')
        expect(page).to have_unchecked_field('アニメ・ボカロ')
        expect(page).to have_unchecked_field('K-POP/洋楽')
        expect(page).to have_unchecked_field('アイドルソング')
        expect(page).to have_unchecked_field('Hip Hop/R&B')
        expect(page).to have_unchecked_field('演歌・歌謡曲')
      end

      within '.repertoire_grid' do
        expect(page).to have_css('.repertoire_item')
      end
    end
  end
end
