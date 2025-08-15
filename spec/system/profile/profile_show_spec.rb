require 'rails_helper'

RSpec.describe 'プロフィール表示', type: :system do
  let(:user) { create(:user) }

  before do
    login_as_user(user)
    visit user_profile_path
  end

  describe "プロフィール情報が表示されている" do
    it 'プロフィール画面にデフォルトアイコン画像とユーザー名が表示されている' do
      within '.account_container' do
        image_tag = find(".user-avatar")
        expect(image_tag[:src]).to match(/default_icon.*\.png/)
        expect(page).to have_content user.name
      end
    end
  end

  describe 'アイコン画像が登録されている場合' do
    it '登録されたアイコン画像が表示される' do
      visit edit_user_profile_path
      attach_file 'user_image', Rails.root.join('spec/fixtures/images/user_icon_for_test.png')
      click_button '保存'
      expect(page).to have_current_path(user_profile_path)

      within '.account_container' do
        image_tag = find('.user-avatar')
        expect(image_tag[:src]).to include('user_icon_for_test.png')
      end
    end
  end

  describe '編集ボタンで画面遷移' do
    it '編集ボタンを押すとプロフィール編集ページに遷移する' do
      click_on '編集'
      expect(current_path).to eq edit_user_profile_path
    end
  end
end
