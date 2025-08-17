require 'rails_helper'

RSpec.describe '練習ログ登録', type: :system do
  let(:user){ create(:user) }
  let(:practice) { build(:practice) }

  before do
    login_as_user(user)
    visit new_practice_path
  end

  describe "練習ログ登録が成功する場合" do
    it '練習ログ登録が成功する（登録後はマイページに自動遷移）' do
      fill_in '曲名', with: practice.title
      fill_in 'アーティスト', with: practice.artist
      fill_in 'キー', with: practice.key
      fill_in 'スコア', with: practice.score
      attach_file '結果画像1', Rails.root.join('spec/fixtures/images/test_result_image1.png')
      attach_file '結果画像2', Rails.root.join('spec/fixtures/images/test_result_image2.png')
      fill_in '練習メモ', with: practice.comment
      click_button '保存'
      expect(page).to have_current_path(mypage_path)
      expect(page).to have_content '練習ログを新規登録しました'

      within '.practice_list' do
        expect(page).to have_content practice.title
        expect(page).to have_content practice.artist
        expect(page).to have_content practice.key_display
        expect(page).to have_content practice.score
        expect(page).to have_content practice.comment

        within '.result_images' do
          expect(page).to have_selector("img[src*='test_result_image1.png']")
          expect(page).to have_selector("img[src*='test_result_image2.png']")
        end
      end

      within '.user_stats' do
        practices_stat = find('.stat_item', text: '練習回数').find('.stat_value')
        expect(Integer(practices_stat.text, 10)).to be > 0

        practices_stat = find('.stat_item', text: '平均スコア').find('.stat_value')
        expect(Float(practices_stat.text)).to be > 0
      end
    end

    it 'キー、スコア、練習メモ、結果画像が空欄でも練習ログ登録が成功する（登録後はマイページに自動遷移）' do
      fill_in '曲名', with: practice.title
      fill_in 'アーティスト', with: practice.artist
      fill_in 'キー', with: ''
      fill_in 'スコア', with: ''
      fill_in '練習メモ', with: ''
      click_button '保存'
      expect(page).to have_current_path(mypage_path)
      expect(page).to have_content '練習ログを新規登録しました'

      within '.practice_list' do
        expect(page).to have_content practice.title
        expect(page).to have_content practice.artist
        expect(page).to have_content practice.key_display
        expect(page).to have_content 'スコア: なし'

        within '.practice_memo' do
          expect(page.text).to eq ''
        end

        within '.result_images' do
          expect(page).to have_content '採点結果画像①'
          expect(page).to have_content '採点結果画像②'
        end
      end

      within '.user_stats' do
        practices_stat = find('.stat_item', text: '練習回数').find('.stat_value')
        expect(Integer(practices_stat.text, 10)).to be > 0
      end
    end
  end

  describe "練習ログ登録が失敗する場合" do
    it '必須項目を空で送信するとエラーが出る' do
      click_button '保存'
      expect(page).to have_current_path(practices_path)
      expect(page).to have_content '曲名を入力してください'
      expect(page).to have_content 'アーティスト名を入力してください'
    end

    it '練習練習メモの文字数が200文字を文字を超えるとエラーが出る' do
      fill_in '曲名', with: practice.title
      fill_in 'アーティスト', with: practice.artist
      fill_in 'キー', with: practice.key
      fill_in '練習メモ', with: 'a' * 201
      click_button '保存'
      expect(page).to have_current_path(practices_path)
      expect(page).to have_content '練習メモは200文字以内で入力してください'
    end
  end

  describe "キャンセルする（登録しない）場合" do
    it 'キャンセルリンクを押すとマイページに遷移する' do
      click_on 'キャンセル'
      expect(current_path).to eq mypage_path
    end
  end
end
