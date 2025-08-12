require 'rails_helper'

RSpec.describe 'ユーザー新規登録', type: :system do
  let!(:user){ create(:user, email: 'registered@example.com') }

  before do
    visit new_user_registration_path
  end

  describe "アカウント新規登録が成功する場合" do
    it '新規登録が成功する' do
      fill_in 'ユーザー名', with: 'テストユーザー'
      fill_in 'メールアドレス', with: 'test@example.com'
      fill_in 'パスワード', with: 'password'
      fill_in '確認用パスワード', with: 'password'
      click_button '新しいアカウントを作成'
      expect(page).to have_current_path(user_profile_path)
      expect(page).to have_content 'アカウント登録が完了しました'
      expect(page).to have_content 'テストユーザー'
    end
  end

  describe "アカウント新規登録が失敗する場合" do
    it '必須項目を空で送信するとエラーが出る' do
      click_button '新しいアカウントを作成'
      expect(page).to have_content 'メールアドレスを入力してください'
      expect(page).to have_content 'パスワードを入力してください'
      expect(page).to have_content 'ユーザー名を入力してください'
    end

    it '登録済みのメールアドレスを使用するとエラーが出る' do
      fill_in 'メールアドレス', with: user.email
      click_button '新しいアカウントを作成'
      expect(page).to have_content 'メールアドレスはすでに使用されています'
    end

    it 'パスワードと確認用パスワードが異なるとエラーが出る' do
      fill_in 'パスワード', with: 'password'
      fill_in '確認用パスワード', with: 'different_password'
      click_button '新しいアカウントを作成'
      expect(page).to have_content 'パスワード（確認）とパスワードの入力が一致しません'
    end

    it 'パスワードが6文字未満の場合エラーが出る' do
      fill_in 'パスワード', with: 'pass'
      fill_in '確認用パスワード', with: 'pass'
      click_button '新しいアカウントを作成'
      expect(page).to have_content 'パスワードは6文字以上で入力してください'
    end
  end

  describe "アカウントを持っている場合" do
    it 'ログインページに遷移する' do
      click_link 'アカウントをお持ちの方はログイン'
      expect(current_path).to eq new_user_session_path
    end
  end
end
