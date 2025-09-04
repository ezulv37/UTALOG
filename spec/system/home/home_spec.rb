require 'rails_helper'
require 'ostruct'

RSpec.describe 'ホームページ', type: :system do
  let(:user1) { create(:user) }

  let(:user2) do
    create(:user).tap do |user|
      user.image.attach(
        io: Rails.root.join('spec/fixtures/images/user_icon_for_test.png').open,
        filename: 'user_icon_for_test.png',
        content_type: 'image/png'
      )
    end
  end

  let!(:practice1) { create(:practice, user: user1, title: '歌1', artist: 'アーティスト1', score: 80, key: '2', comment: 'コメント1') }
  let!(:practice2) { create(:practice, user: user2, title: '歌2', artist: 'アーティスト2') }

  before do
    # YouTube API のモック
    youtube_double = double('youtube_service')
    allow(Rails.application.config).to receive(:youtube_service).and_return(youtube_double)

    # デフォルト検索（ページ読み込み時）
    allow(youtube_double).to receive(:list_searches).with(
      'snippet',
      hash_including(q: '歌唱 テクニック')
    ).and_return(
      OpenStruct.new(
        items: [
          OpenStruct.new(
            id: OpenStruct.new(kind: 'youtube#video', video_id: 'default123'),
            snippet: OpenStruct.new(title: 'デフォルト動画', thumbnails: OpenStruct.new(default: OpenStruct.new(url: 'https://example.com/default.jpg')))
          )
        ]
      )
    )

    # キーワード検索用
    allow(youtube_double).to receive(:list_searches).with(
      'snippet',
      hash_including(q: 'アーティスト1')
    ).and_return(
      OpenStruct.new(
        items: [
          OpenStruct.new(
            id: OpenStruct.new(kind: 'youtube#video', video_id: 'search123'),
            snippet: OpenStruct.new(title: '検索結果動画', thumbnails: OpenStruct.new(default: OpenStruct.new(url: 'https://example.com/search.jpg')))
          )
        ]
      )
    )

    visit root_path
  end

  describe '未ログイン時' do
    it 'サインアップとログインリンクがある' do
      expect(page).to have_content('UTALOG')
      expect(page).to have_link('新規登録してはじめる')
      expect(page).to have_link('ログインしてはじめる')
    end

    it 'サインアップリンクをクリックでアカウント新規登録ページに遷移する' do
      click_link '新規登録してはじめる', href: new_user_registration_path
      expect(current_path).to eq(new_user_registration_path)
    end

    it 'ログインリンクをクリックでログインページに遷移する' do
      click_link 'ログインしてはじめる', href: new_user_session_path
      expect(current_path).to eq(new_user_session_path)
    end
  end

  describe 'ログイン時' do
    before do
      login_as_user(user1)
    end

    it 'サインアップとログインリンクが表示されない' do
      expect(page).to have_content('UTALOG')
      expect(page).not_to have_link('新規登録してはじめる')
      expect(page).not_to have_link('ログインしてはじめる')
    end
  end

  describe 'YouTube動画表示' do
    it 'デフォルト動画が表示される' do
      expect(page).to have_content('デフォルト動画')
      expect(page).to have_selector("iframe[src*='default123']")
    end

    it '検索フォームで動画を切り替えられる' do
      fill_in 'query', with: 'アーティスト1'
      click_button '検索'

      # ページが再読み込みされ、検索結果が表示される
      expect(page).to have_content('検索結果動画')
      expect(page).to have_selector("iframe[src*='search123']")
      # デフォルト動画は表示されない
      expect(page).not_to have_content('デフォルト動画')
    end

    it '動画が最大１件表示される' do
      expect(page).to have_css('.video', count: 1)
    end
  end

  describe '公開練習ログ表示' do
    it '公開練習ログが表示される' do
      # ユーザー1の練習ログ
      within all('.log_card')[1] do
        expect(page).to have_content(user1.name)
        image_tag = find(".open_practice_log_icon_image")
        expect(image_tag[:src]).to match(/default_icon.*\.png/)
        expect(page).to have_content(practice1.created_at.strftime('%Y/%m/%d %H:%M'))
        expect(page).to have_content(practice1.title)
        expect(page).to have_content(practice1.artist)
        expect(page).to have_content(practice1.key_display)
        expect(page).to have_content("スコア: #{practice1.score}点")
        expect(page).to have_content(practice1.comment)
      end

      # ユーザー2の練習ログ
      within all('.log_card')[0] do
        expect(page).to have_content(user2.name)
        image_tag = find('.open_practice_log_icon_image')
        expect(image_tag[:src]).to include('user_icon_for_test.png')
        expect(page).to have_content(practice2.created_at.strftime('%Y/%m/%d %H:%M'))
        expect(page).to have_content(practice2.title)
        expect(page).to have_content(practice2.artist)
        expect(page).to have_content(practice2.key_display)
        expect(page).to have_content(practice2.score)

        within '.log_practice_comment' do
          expect(page).to have_content('')
        end
      end
    end

    it '公開練習ログが新しい日付の順に表示される' do
      dates = all('.log_card .created_at').map(&:text)
      expect(dates).to eq dates.sort.reverse
    end
  end
end
