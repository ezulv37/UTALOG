require 'rails_helper'

RSpec.describe 'マイページ（練習ログタブ）', type: :system, js: true do
  let(:user){ create(:user) }
  let!(:practice_a) { create(:practice, user: user, title: "あいうえお", artist: "A") }
  let!(:practice_b) { create(:practice, user: user, title: "さしすせそ", artist: "B") }
  let!(:practice_c) { create(:practice, user: user, title: "あかさたな", artist: "B") }
  let(:practices) { [practice_a, practice_b, practice_c] }

  before do
    login_via_ui(user)
    visit mypage_path
    click_on '楽曲レパートリー'
    click_on '練習ログ'
    expect(page).to have_selector('#practice_log', visible: true)
  end

  describe '練習ログ検索' do
    it '曲名で検索すると、該当の練習ログだけが表示される' do
      within '#practice_log .search_input_container' do
        find('[data-testid="practice-search"]').set('あ')
        expect(page).to have_field(nil, with: 'あ')
        click_on '検索'
      end

      within '#practice_log .practice_list' do
        expect(page).to have_content(practice_a.title)
        expect(page).to have_content(practice_a.artist)
        expect(page).to have_content(practice_c.title)
        expect(page).to have_content(practice_c.artist)
        expect(page).not_to have_content(practice_b.title)
      end
    end

    it 'アーティスト名で検索すると、該当の練習ログが表示される' do
      within '#practice_log .search_input_container' do
        fill_in 'practice_q', with: "B"
        click_on '検索'
      end

      within '#practice_log .practice_list' do
        expect(page).to have_content(practice_b.title)
        expect(page).to have_content(practice_b.artist)
        expect(page).to have_content(practice_c.title)
        expect(page).to have_content(practice_c.artist)
        expect(page).not_to have_content(practice_a.title)
        expect(page).not_to have_content(practice_a.artist)
      end
    end
  end

  describe '練習ログ情報' do
    it '全練習ログの情報（曲名、アーティスト、キー、スコア、コメント、登録日時、編集・削除ボタン）が表示される' do
      practices.each do |practice|
        expect(page).to have_content(practice.title)
        expect(page).to have_content(practice.artist)
        expect(page).to have_content(practice.key_display)
        expect(page).to have_content(practice.score)
        expect(page).to have_selector("img[src*='est_result_image1.png']")
        expect(page).to have_selector("img[src*='est_result_image2.png']")
        expect(page).to have_content(practice.comment)
        expect(page).to have_content(practice.created_at.strftime('%Y/%m/%d %H:%M'))
        expect(page).to have_link '編集'
        expect(page).to have_link '削除'
      end
    end

    it '練習ログが新しい日付の順に表示される' do
      dates = all('.practice_item .created_at').map(&:text)
      expect(dates).to eq dates.sort.reverse
    end
  end

  describe '練習ログの編集・削除' do
    it '編集ボタンをクリックすると、練習ログ編集画面に遷移する', js: false do
      edit = find("a.practice_edit_button[href='#{edit_practice_path(practice_c)}']")
      edit.click
      expect(current_path).to eq(edit_practice_path(practice_c))
    end

    it '削除ボタンで削除できる' do
      accept_confirm do
        delete = find("a.practice_delete_button[href='#{practice_path(practice_c)}']")
        delete.click
      end
      expect(page).not_to have_content(practice_c.title)
    end

    it '削除ボタンでキャンセルすると残る' do
      dismiss_confirm do
        delete = find("a.practice_delete_button[href='#{practice_path(practice_c)}']")
        delete.click
      end
      expect(page).to have_content(practice_c.title)
      expect(page).to have_content(practice_c.artist)
    end
  end
end
