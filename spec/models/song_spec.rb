require 'rails_helper'

RSpec.describe Song, type: :model do
  let(:song) { build(:song) }
  let(:user) { create(:user) }
  let(:saved_song) { create(:song, user: user) }

  describe 'songモデルのバリデーションに関するテスト' do
    it '楽曲タイトル、アーティスト名、ジャンルがある場合は有効' do
      expect(song).to be_valid
    end

    it '楽曲タイトルがない場合は無効' do
      song.title = nil
      expect(song).to be_invalid
    end

    it 'アーティスト名がない場合は無効' do
      song.artist = nil
      expect(song).to be_invalid
    end

    it 'ジャンルが選択されていない場合は無効' do
      song.genre = nil
      expect(song).to be_invalid
    end

    it 'キーが整数である場合は有効' do
      song.key = 0
      expect(song).to be_valid
    end

    it 'キーが数値でない場合は無効' do
      song.key = 'string'
      expect(song).to be_invalid
    end

    it 'キーが整数でない場合は無効' do
      song.key = 3.5
      expect(song).to be_invalid
    end

    it 'キーが空欄でも有効' do
      song.key = nil
      expect(song).to be_valid
    end

    it 'メモが200文字を超える場合は無効' do
      song.memo = 'a' * 201
      expect(song).to be_invalid
    end

    it 'メモが空欄でも有効' do
      song.memo = nil
      expect(song).to be_valid
    end
  end

  describe 'songモデルのアソシエーションに関するテスト' do
    it 'userモデルとのアソシエーションが正しく設定されていること' do
      expect(user.songs).to include(saved_song)
    end
  end
end
