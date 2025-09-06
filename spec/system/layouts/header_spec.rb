require 'rails_helper'

RSpec.describe 'ヘッダー', type: :system do
  let(:user) { create(:user) }

  before do
    visit new_user_registration_path
  end

  describe "未ログイン時" do
    it 'サイトロゴが表示されている' do
      logo = find(".logo")
      expect(logo[:src]).to match(/logo.*\.png/)
    end

    it 'サイトロゴクリックでホームページに遷移する' do
      find('.logo_container a').click
      expect(current_path).to eq(root_path)
    end

    it '新規登録リンクとログインリンクが表示されている' do
      expect(page).to have_link('新規登録')
      expect(page).to have_link('ログイン')
    end

    it 'max-width: 545px以下で新規登録リンクとログインリンクが非表示になる', js: true do
      page.driver.browser.manage.window.resize_to(500, 800)
      expect(page).to have_css('.signup_link', visible: false)
      expect(page).to have_css('.signin_link', visible: false)
    end

    it '「新規登録」を押すとアカウント新規登録ページに遷移する' do
      click_on '新規登録'
      expect(current_path).to eq(new_user_registration_path)
    end

    it '「ログイン」を押すとログインページに遷移する' do
      click_on 'ログイン'
      expect(current_path).to eq(new_user_session_path)
    end
  end

  describe 'ログイン時' do
    before do
      login_as_user(user)
    end

    it 'サイトロゴが表示されている' do
      logo = find(".logo")
      expect(logo[:src]).to match(/logo.*\.png/)
    end

    it '「練習する」リンクが表示されている' do
      expect(page).to have_link('練習する')
    end

    it 'max-width: 545px以下で「+」リンクが表示される', js: true do
      page.driver.browser.manage.window.resize_to(500, 800)
      expect(page).to have_css('.header_new_practice_link-b', visible: true)
      expect(page).to have_css('.header_new_practice_link-a', visible: false)
    end

    it 'アイコンの登録がない場合、デフォルト画像が表示されている' do
      within '.nav_item' do
        icon = find('.header_icon_image')
        expect(icon[:src]).to match(/default_icon.*\.png/)
      end
    end

    it 'アイコンの登録がある場合、登録した画像が表示されている' do
      visit edit_user_profile_path
      attach_file 'user_image', Rails.root.join('spec/fixtures/images/user_icon_for_test.png')
      click_button '保存'

      within '.nav_item' do
        icon = find('.header_icon_image')
        expect(icon[:src]).to include('user_icon_for_test.png')
      end
    end

    it 'ユーザー名が表示されている' do
      expect(page).to have_content(user.name)
    end

    it '新規登録ボタンとログインリンクが表示されない' do
      expect(page).not_to have_link('新規登録')
      expect(page).not_to have_link('ログイン')
    end

    it 'サイトロゴクリックでホームページに遷移する' do
      find('.logo_container a').click
      expect(current_path).to eq(root_path)
    end

    it '「練習する」を押すと練習ログ登録ページに遷移する' do
      find('.header_new_practice_link-a').click
      expect(current_path).to eq(new_practice_path)
    end

    it '「+」リンクを押すと練習ログ登録ページに遷移する', js: true do
      page.driver.browser.manage.window.resize_to(500, 800)
      find('.header_new_practice_link-b').click
      expect(current_path).to eq(new_practice_path)
    end

    it 'ユーザー名クリックでドロップダウンメニューが開く', js: true do
      find('.dropdown').click
      expect(page).to have_content 'マイページ'
      expect(page).to have_content 'プロフィール'
      expect(page).to have_content 'アカウント'
      expect(page).to have_content 'ログアウト'
    end

    it '外部クリックでドロップダウンメニューが閉じる', js: true do
      find('.dropdown').click
      expect(page).to have_content 'マイページ'
      find('body').click
      expect(page).not_to have_content 'マイページ'
    end
  end

  describe 'ドロップダウンメニュー(ログイン時)', js: true do
    before do
      login_as_user(user)
      find('.dropdown').click
    end

    it 'ドロップダウンメニューの「マイページ」を押すとマイページに遷移する' do
      click_on 'マイページ'
      expect(current_path).to eq(mypage_path)
    end

    it 'ドロップダウンメニューの「プロフィール」を押すとプロフィール詳細ページに遷移する' do
      click_on 'プロフィール'
      expect(current_path).to eq(user_profile_path)
    end

    it 'ドロップダウンメニューの「アカウント」を押すとアカウント詳細ページに遷移する' do
      click_on 'アカウント'
      expect(current_path).to eq(user_account_path)
    end

    it 'ドロップダウンメニューの「ログアウト」を押すとログアウトし、ホームページに遷移する(ユーザー名が非表示、ユーザー認証リンクが表示される)' do
      click_on 'ログアウト'
      expect(page).to have_current_path(root_path)
      expect(page).to have_content 'ログアウトしました'
      expect(page).not_to have_content user.name
      expect(page).to have_link('新規登録')
      expect(page).to have_link('ログイン')
    end
  end
end
