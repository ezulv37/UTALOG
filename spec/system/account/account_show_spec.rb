require 'rails_helper'

RSpec.describe 'アカウント表示', type: :system do
  let(:user) { create(:user) }

  before do
    login_as_user(user)
    visit user_account_path
  end

  describe "アカウント情報が表示されている" do
    it 'アカウント画面にメールアドレスとパスワード（マスク）が表示されている' do
      within '.account_container' do
        expect(page).to have_content user.email
        expect(page).to have_content '*********'
      end
    end
  end

  describe '編集ボタンで画面遷移' do
    it '編集ボタンを押すとアカウント編集ページに遷移する' do
      click_on '編集'
      expect(current_path).to eq edit_user_registration_path
    end
  end
end
