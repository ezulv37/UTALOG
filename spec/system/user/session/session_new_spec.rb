require 'rails_helper'

RSpec.describe 'ユーザーログイン', type: :system do
  let!(:user) { create(:user) }

  before do
    visit new_user_session_path
  end

  describe 'ログインが成功する場合' do
    it '正しいメールアドレスとパスワードでログインできる' do
      fill_in 'メールアドレス', with: user.email
      fill_in 'パスワード', with: user.password
      click_button 'ログイン'
      expect(page).to have_current_path(mypage_path)
      expect(page).to have_content 'ログインしました'
      expect(page).to have_content user.name
    end
  end

  describe 'ログインが失敗する場合' do
    it 'メールアドレスとパスワードを空で送信するとエラーが出る' do
      click_button 'ログイン'
      expect(page).to have_content 'メールアドレスまたはパスワードが正しくありません'
    end

    it '存在しないメールアドレスの場合エラーが出る' do
      fill_in 'メールアドレス', with: 'wrong@example.com'
      fill_in 'パスワード', with: user.password
      click_button 'ログイン'
      expect(page).to have_content 'メールアドレスまたはパスワードが正しくありません'
    end

    it 'パスワードが間違っている場合エラーが出る' do
      fill_in 'メールアドレス', with: user.email
      fill_in 'パスワード', with: 'wrongpassword'
      click_button 'ログイン'
      expect(page).to have_content 'メールアドレスまたはパスワードが正しくありません'
    end
  end

  describe '新規登録が必要な場合' do
    it '新規登録ページに遷移する' do
      click_link 'アカウントをお持ちでない方は新規作成'
      expect(current_path).to eq new_user_registration_path
    end
  end
end
