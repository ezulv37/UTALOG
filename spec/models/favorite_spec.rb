require 'rails_helper'

RSpec.describe Favorite, type: :model do
  let(:user) { create(:user) }
  let(:song) { create(:song, user: user) }
  let(:saved_favorite) { create(:favorite, user: user, song: song) }

  describe 'favoriteモデルのバリデーションに関するテスト' do
    it 'userとsongが存在する場合は有効' do
      favorite = build(:favorite, user: user, song: song)
      expect(favorite).to be_valid
    end

    it 'userが存在しない場合は無効' do
      favorite = build(:favorite, user: nil, song: song)
      expect(favorite).to be_invalid
    end

    it 'songが存在しない場合は無効' do
      favorite = build(:favorite, user: user, song: nil)
      expect(favorite).to be_invalid
    end

    it '同じuserが同じsongを重複してお気に入り登録できないこと' do
      create(:favorite, user: user, song: song)
      favorite2 = build(:favorite, user: user, song: song)
      expect(favorite2).to be_invalid
    end
  end

  describe 'favoriteモデルのアソシエーションに関するテスト' do
    it 'userモデルとのアソシエーションが正しく設定されていること' do
      expect(user.favorites).to include(saved_favorite)
    end

    it 'songモデルとのアソシエーションが正しく設定されていること' do
      expect(song.favorites).to include(saved_favorite)
    end
  end
end
