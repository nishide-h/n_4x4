require "rails_helper"

describe "Header", type: :system do
  let!(:user_a) { FactoryBot.create(:valid_user) }

  describe "ロゴクリック" do
    xcontext "ログイン前" do
      before do
        visit root_path
      end

      it "root画面へ遷移すること" do
        find("img#logo").click

        expect(current_path).to eq root_path
      end
    end

    context "ユーザーAアカウント" do
      before do
        visit new_user_session_path
        fill_in "Eメール", with: user_a.email
        fill_in "パスワード", with: user_a.password
        click_button "Log in"
      end

      it "トップページへ遷移すること" do
        find("img#logo").click

        expect(current_path).to eq sheets_path
      end
    end
  end
end

