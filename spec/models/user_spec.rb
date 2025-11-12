require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { build(:user) }
  let(:saved_user) { create(:user) }
  let(:song) { create(:song) }

  describe 'userモデルのバリデーションに関するテスト' do
    it '名前、メールアドレス、パスワードがある場合は有効' do
      expect(user).to be_valid
    end

    it '名前がない場合は無効' do
      user.name = nil
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
      user.password = nil
      expect(user).to be_invalid
    end

    it 'パスワードと確認用パスワードが一致しない場合は無効' do
      user.password_confirmation = 'mismatch'
      expect(user).to be_invalid
    end
  end

  describe '画像添付のテスト' do
    it '画像を添付できること' do
      user_with_image = create(:user)
      user_with_image.image.attach(
        io: Rails.root.join('spec/fixtures/images/user_icon_for_test.png').open,
        filename: 'user_icon_for_test.png',
        content_type: 'image/png'
      )
      expect(user_with_image.image).to be_attached
    end

    it '画像が添付されていない場合でも有効であること' do
      user_no_image = create(:user)
      user_no_image.image.purge
      expect(user_no_image).to be_valid
    end
  end

  describe 'userモデルのアソシエーションに関するテスト' do
    it 'songモデルとのアソシエーションが正しく設定されていること' do
      song = create(:song, user: saved_user)
      expect(saved_user.songs).to include song
    end

    it 'practiceモデルとのアソシエーションが正しく設定されていること' do
      practice = create(:practice, user: saved_user)
      expect(saved_user.practices).to include practice
    end

    it 'favoriteモデルとのアソシエーションが正しく設定されていること' do
      favorite = create(:favorite, user: saved_user)
      expect(saved_user.favorites).to include favorite
    end

    it '中間テーブルfavorite_songs（through: :favorites, source: :song）が正しく設定されていること' do
      song = create(:song)
      create(:favorite, user: saved_user, song: song)
      expect(saved_user.favorite_songs).to include song
    end
  end
end
