require 'rails_helper'

RSpec.describe Practice, type: :model do
  let(:practice) { build(:practice) }
  let(:user) { create(:user) }
  let(:saved_practice) { create(:practice, user: user) }

  describe 'バリデーションのテスト' do
    it '楽曲タイトルとアーティスト名がある場合は有効' do
      expect(practice).to be_valid
    end

    it '楽曲タイトルがない場合は無効' do
      practice.title = nil
      expect(practice).to be_invalid
    end

    it 'アーティスト名がない場合は無効' do
      practice.artist = nil
      expect(practice).to be_invalid
    end

    it 'キーが整数である場合は有効' do
      practice.key = 0
      expect(practice).to be_valid
    end

    it 'キーが数値でない場合は無効' do
      practice.key = 'string'
      expect(practice).to be_invalid
    end

    it 'キーが整数でない場合は無効' do
      practice.key = 0.1
      expect(practice).to be_invalid
    end

    it 'キーが空欄でも有効' do
      practice.key = nil
      expect(practice).to be_valid
    end

    it 'スコアが負の数である場合は無効' do
      practice.score = -1
      expect(practice).to be_invalid
    end

    it 'コメントが200文字を超える場合は無効' do
      practice.comment = "a" * 201
      expect(practice).to be_invalid
    end

    describe '画像添付のテスト' do
      it '画像を添付できること' do
        expect(practice.result_image1).to be_attached
        expect(practice.result_image2).to be_attached
      end

      it '画像が添付されていない場合でも有効であること' do
        practice.result_image1 = nil
        practice.result_image2 = nil
        expect(practice).to be_valid
      end
    end

    describe 'practiceモデルのアソシエーションに関するテスト' do
      it 'userモデルとのアソシエーションが正しく設定されていること' do
        expect(user.practices).to include(saved_practice)
      end
    end
  end
end
