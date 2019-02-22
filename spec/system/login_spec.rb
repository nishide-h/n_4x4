require "rails_helper"

describe "Login", type: :system do
  let!(:valid_user) { FactoryBot.create(:valid_user) }

  describe "ユーザー登録" do
    before do
      visit new_user_registration_path
    end

    it "Sine Up画面へ遷移すること" do
      expect(page).to have_content("Sign up")
    end

    it "ユーザーが登録できること" do
      fill_in "Eメール", with: "test@example.com"
      fill_in "パスワード", with: "testtest"
      fill_in "パスワード（確認用）", with: "testtest"
      click_button "Sign up"

      expect(page).to have_content("test@example.com")
    end
  end

  describe "ログインできること" do 
    before do
      visit new_user_session_path
    end

    it "ログイン画面へ遷移すること" do
      expect(page).to have_content("Log in")
    end

    it "ログイン" do
      fill_in "Eメール", with: valid_user.email
      fill_in "パスワード", with: valid_user.password
      click_button "Log in"

      expect(page).to have_content("valid@example.com")
    end
  end

  describe "ログオフできること" do
    before do
      visit new_user_session_path
      fill_in "Eメール", with: valid_user.email
      fill_in "パスワード", with: valid_user.password
      click_button "Log in"
    end

    it "ログオフ" do
      click_link "ログアウト"

      expect(page).to have_content("ログアウトしました。")
    end
  end
end

