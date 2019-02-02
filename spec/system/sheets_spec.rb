require "rails_helper"

describe "Sheet", type: :system do
  let!(:sheet_a) { FactoryBot.create(:sheet) }
  let!(:sheet_b) { FactoryBot.create(:sheet_b) }

  describe "create" do
    before do
      visit root_path
    end

    it "シートが作成でき、一覧に表示されること" do
      click_link "シート作成"

      fill_in "シート名", with: "今日やること"
      click_button "登録する"

      expect(page).to have_content "今日やること"
    end

    xit "シートが作成後、タスク登録画面へ遷移すること" do
      click_link "シート作成"

      fill_in "シート名", with: "今日やること"
      click_button "登録する"

      # "シート作成後、すぐにタスク登録画面が表示されること"
      expect(page).to have_selector("h1", text: "New Task")
    end
  end
end

