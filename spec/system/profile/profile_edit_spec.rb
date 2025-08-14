require 'rails_helper'

RSpec.describe 'プロフィール編集', type: :system do
  let(:user) { create(:user) }

  before do
    login_as_user(user)
    visit edit_user_profile_path
  end

  describe "プロフィールの編集更新が成功する場合" do
    it 'プロフィール編集画面にデフォルトアイコン画像とユーザー名が表示されている' do
      within '.edit_user_avatar_container' do
        image_tag = find(".edit_user_avatar")
        expect(image_tag[:src]).to match(/default_icon.*\.png/)
      end

      within '.account_information' do
        expect(page).to have_field('名前', with: user.name)
      end
    end

    it 'ユーザー名の変更が成功する=>プロフィール詳細ページに遷移し、変更後のユーザー名が表示される' do
      fill_in '名前', with: 'new_user_name'
      click_button '保存'
      expect(page).to have_current_path(user_profile_path)

      within '.account_container' do
        expect(page).to have_content 'new_user_name'
      end
    end

    it 'アイコン画像の変更が成功する=>プロフィール詳細ページに遷移し、変更後のアイコン画像が表示される' do
      attach_file 'user_image', Rails.root.join('spec/fixtures/images/user_icon_for_test.png')
      click_button '保存'
      expect(page).to have_current_path(user_profile_path)

      within '.account_container' do
        image_tag = find('.user-avatar')
        expect(image_tag[:src]).to include('user_icon_for_test.png')
      end
    end

    it '何も入力せず保存を押すとそのままの結果が反映される' do
      click_button '保存'
      expect(page).to have_current_path(user_profile_path)

      within '.account_container' do
        expect(page).to have_content user.name
        image_tag = find('.user-avatar')
        expect(image_tag[:src]).to match(/default_icon.*\.png/)
      end
    end
  end

  describe 'プロフィールの編集更新が失敗する場合' do
    it 'ユーザー名が空欄だとエラーが出る' do
      fill_in '名前', with: ''
      click_button '保存'
      expect(page).to have_content 'ユーザー名を入力してください'
    end
  end

  describe 'キャンセルする（編集しない）場合' do
    it 'キャンセルリンクを押すとプロフィール詳細ページに遷移する' do
      click_on 'キャンセル'
      expect(current_path).to eq user_profile_path
    end
  end

  describe "アイコン画像を削除する場合" do
    before do
      attach_file 'user_image', Rails.root.join('spec/fixtures/images/user_icon_for_test.png')
      click_button '保存'
      expect(page).to have_current_path(user_profile_path)
      visit edit_user_profile_path
      expect(page).to have_css('.account_item_inputform')
    end

    it '画像削除チェックボックスが表示され、削除後はデフォルト画像が表示される' do
      within '.edit_user_avatar_container' do
        image_tag = find('.edit_user_avatar')
        expect(image_tag[:src]).to include('user_icon_for_test.png')
      end

      within '.remove_image_field' do
        expect(page).to have_css('.avatar_delete_checkbox')
        check '画像を削除する'
      end

      click_button '保存'

      expect(page).to have_current_path(user_profile_path)
      expect(page).to have_content 'プロフィールを更新しました'

      within '.account_container' do
        image_tag = find('.user-avatar')
        expect(image_tag[:src]).to match(/default_icon.*\.png/)
      end
    end
  end
end
