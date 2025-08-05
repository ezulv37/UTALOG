require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'ユーザーのバリデーションに関するテスト' do
    it '名前、メールアドレス、パスワードがある場合は有効' do
      valid_user = FactoryBot.build(:user)
      expect(valid_user).to be_valid
    end

    it '名前がない場合は無効' do
      user_without_name = FactoryBot.build(:user, name: ' ')
      expect(user_without_name).to be_invalid
    end

    it '名前が25文字を超える場合は無効' do
      longer_name_user = FactoryBot.build(:user, name: 'a' * 26)
      expect(longer_name_user).to be_invalid
    end

    it '重複したメールアドレスは無効' do
      user = FactoryBot.create(:user)
      user_duplicate_email = FactoryBot.build(:user, email: user.email)
      expect(user_duplicate_email).to be_invalid
    end

    it 'パスワードがない場合は無効' do
      user_without_password = FactoryBot.build(:user, password: ' ')
      expect(user_without_password).to be_invalid
    end

    it 'パスワードと確認用パスワードが一致しない場合は無効' do
      user_password_mismatch = FactoryBot.build(:user, password_confirmation: 'mismatch')
      expect(user_password_mismatch).to be_invalid
    end
  end

  describe '画像添付のテスト' do
    before do
      @user = FactoryBot.build(:user)
    end

    it '画像を添付できること' do
      @user.image.attach(
        io: File.open(Rails.root.join('spec/fixtures/images/test_icon_image.png').open),
        filename: 'test_icon_image.png',
        content_type: 'image/png'
      )

      expect(@user.image).to be_attached
    end

    it '画像が添付されていない場合でも有効であること' do
      expect(@user).to be_valid
      expect(@user.image.attached?).to be false
    end
  end
end
