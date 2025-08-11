require 'rails_helper'

RSpec.describe 'アカウント編集', type: :system do
  let(:user) { create(:user) }

  before do
    visit new_user_session_path
    fill_in 'メールアドレス', with: user.email
    fill_in 'パスワード', with: user.password
    click_button 'ログイン'
    expect(page).to have_content(user.name)
    visit edit_user_registration_path
  end

  describe "アカウント情報の編集更新が成功する場合" do
    it 'パスワードの変更が成功する=>自動ログアウトしてホームページに遷移、ヘッダーにサインインメニューが表示される' do
      fill_in '新しいパスワード', with: 'new_password'
      fill_in 'パスワード確認', with: 'new_password'
      fill_in '現在のパスワード', with: user.password
      click_button '保存'
      expect(page).to have_current_path(root_path)
      expect(page).to have_content 'パスワードを変更しました'
      expect(page).to have_content 'ログインしてはじめる'

      within 'header' do
        expect(page).to have_content 'ログイン'
        expect(page).to have_content '新規登録'
        expect(page).not_to have_content user.name
      end
    end
  end

  describe "アカウント情報の編集更新が失敗する場合" do
    it '何も入力せず保存を押すとエラーが出る' do
      click_button '保存'
      expect(page).to have_content '現在のパスワードを入力してください'
    end

    it 'パスワードと確認用パスワードが異なるとエラーが出る' do
      fill_in '新しいパスワード', with: 'password'
      fill_in 'パスワード確認', with: 'different_password'
      click_button '保存'
      expect(page).to have_content 'パスワード（確認）とパスワードの入力が一致しません'
    end

    it 'パスワードが6文字未満の場合エラーが出る' do
      fill_in '新しいパスワード', with: 'pass'
      fill_in 'パスワード確認', with: 'pass'
      click_button '保存'
      expect(page).to have_content 'パスワードは6文字以上で入力してください'
    end

    it '現在のパスワードが異なるとエラーが出る' do
      fill_in '新しいパスワード', with: 'new_password'
      fill_in 'パスワード確認', with: 'new_password'
      fill_in '現在のパスワード', with: 'different_password'
      click_button '保存'
      expect(page).to have_content '現在のパスワードは不正な値です'
    end

    it '現在のパスワードが空欄だとエラーが出る' do
      fill_in '現在のパスワード', with: ''
      click_button '保存'
      expect(page).to have_content '現在のパスワードを入力してください'
    end

    it 'パスワードと確認用パスワードを空欄にして現在のパスワードを入力すると更新されない' do
      fill_in '新しいパスワード', with: ''
      fill_in 'パスワード確認', with: ''
      fill_in '現在のパスワード', with: user.password
      click_button '保存'
      expect(page).to have_current_path(edit_user_registration_path)
    end
  end

  describe "キャンセルする（編集しない）場合" do
    it 'キャンセルリンクを押すとアカウント詳細ページに遷移する' do
      click_on 'キャンセル'
      expect(current_path).to eq user_account_path
    end
  end

  describe "アカウントを削除する場合" do
    it 'アカウントを削除=>自動ログアウトしてホームページに遷移、ヘッダーにサインインメニューが表示される' do
      page.accept_confirm do
        click_on 'アカウントを削除'
      end

      expect(page).to have_current_path(root_path)
      expect(page).to have_content 'アカウントを削除しました'
      expect(page).to have_content '新規登録してはじめる'

      within 'header' do
        expect(page).to have_content 'ログイン'
        expect(page).to have_content '新規登録'
        expect(page).not_to have_content user.name
      end
    end
  end
end
