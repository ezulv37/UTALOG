module LoginHelper
  def login_as_user(user)
    visit new_user_session_path
    fill_in 'メールアドレス', with: user.email
    fill_in 'パスワード', with: user.password
    click_button 'ログイン'
    expect(page).to have_current_path(mypage_path)
    expect(page).to have_content(user.name)
  end
end
