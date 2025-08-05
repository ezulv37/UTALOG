require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { build(:user) }
  let(:saved_user) { create(:user) }

  describe 'ユーザーのバリデーションに関するテスト' do
    it '名前、メールアドレス、パスワードがある場合は有効' do
      expect(user).to be_valid
    end

    it '名前がない場合は無効' do
      user.name = ' '
      expect(user).to be_invalid
    end

    it '名前が25文字を超える場合は無効' do
      user.name = 'a' * 26
      expect(user).to be_invalid
    end

    it '重複したメールアドレスは無効' do
      create(:user, email: user.email)
      expect(user).to be_invalid
    end

    it 'パスワードがない場合は無効' do
      user.password = ' '
      expect(user).to be_invalid
    end

    it 'パスワードと確認用パスワードが一致しない場合は無効' do
      user.password_confirmation = 'mismatch'
      expect(user).to be_invalid
    end
  end

  describe '画像添付のテスト' do
    it '画像を添付できること' do
      user.image.attach(
        io: File.open(Rails.root.join('spec/fixtures/images/test_icon_image.png').open),
        filename: 'test_icon_image.png',
        content_type: 'image/png'
      )

      expect(user.image).to be_attached
    end

    it '画像が添付されていない場合でも有効であること' do
      expect(user.image).not_to be_attached
      expect(user).to be_valid
    end
  end

  describe 'ユーザーのアソシエーションに関するテスト' do
    before do
      @user = FactoryBot.create(:user)
    end

    it 'songsとのアソシエーションが正しく設定されていること' do
      song = FactoryBot.create(:song, user: @user)
      expect(@user.songs).to include song
    end

    it 'practicesとのアソシエーションが正しく設定されていること' do
      practice = FactoryBot.create(:practice, user: @user)
      expect(@user.practices).to include practice
    end
  end
end
