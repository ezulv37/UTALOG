require 'rails_helper'

RSpec.describe '練習ログ編集', type: :system do
  let(:user){ create(:user) }
  let(:practice) { create(:practice, user: user) }

  before do
    login_as_user(user)
    visit edit_practice_path(practice)
  end

  describe "練習ログ編集が成功する場合" do
    it '既存の練習ログ情報が表示されている' do
      expect(page).to have_field('曲名', with: practice.title)
      expect(page).to have_field('アーティスト', with: practice.artist)
      expect(page).to have_field('キー', with: practice.key)
      expect(page).to have_field('スコア', with: practice.score)
      expect(page).to have_field('練習メモ', with: practice.comment)
    end

    it '練習ログ編集が成功する（編集後はマイページに自動遷移）' do
      fill_in '曲名', with: 'new_practice_title'
      fill_in 'アーティスト', with: 'new_practice_artist'
      fill_in 'キー', with: 1
      fill_in 'スコア', with: 90
      fill_in '練習メモ', with: 'new_practice_comment'
      click_button '保存'
      expect(page).to have_current_path(mypage_path)
      expect(page).to have_content '練習ログを更新しました'

      within '.practice_list' do
        expect(page).to have_content 'new_practice_title'
        expect(page).to have_content 'new_practice_artist'
        expect(page).to have_content practice.key_display
        expect(page).to have_content '90'
        expect(page).to have_content 'new_practice_comment'
      end
    end

    it 'キー、スコア、練習メモ、結果画像が空欄でも練習ログ編集が成功する（編集後はマイページに自動遷移）' do
      fill_in 'キー', with: ''
      fill_in 'スコア', with: ''
      fill_in '練習メモ', with: ''
      click_button '保存'
      expect(page).to have_current_path(mypage_path)
      expect(page).to have_content '練習ログを更新しました'

      within '.practice_list' do
        expect(page).to have_content practice.title
        expect(page).to have_content practice.artist
        expect(page).to have_content practice.key_display
        expect(page).to have_content 'スコア: なし'

        within '.practice_memo' do
          expect(page.text).to eq ''
        end
      end
    end
  end

  describe "練習ログ編集が失敗する場合" do
    it '必須項目を空で送信するとエラーが出る' do
      fill_in '曲名', with: ''
      fill_in 'アーティスト', with: ''
      click_button '保存'
      expect(page).to have_current_path(practice_path(practice))
      expect(page).to have_content '曲名を入力してください'
      expect(page).to have_content 'アーティスト名を入力してください'
    end

    it '練習メモの文字数が200文字を文字を超えるとエラーが出る' do
      fill_in '練習メモ', with: 'a' * 201
      click_button '保存'
      expect(page).to have_current_path(practice_path(practice))
      expect(page).to have_content '練習メモは200文字以内で入力してください'
    end
  end

  describe "キャンセルする（編集しない）場合" do
    it 'キャンセルリンクを押すとマイページに遷移する' do
      click_on 'キャンセル'
      expect(current_path).to eq mypage_path
    end
  end
end
