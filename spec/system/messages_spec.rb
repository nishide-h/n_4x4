require "rails_helper"

describe "Messages", type: :system do
  let!(:sheet_a) { FactoryBot.create(:sheet) }
  let!(:sheet_b) { FactoryBot.create(:sheet_b) }

  describe "on sheets" do
    before do
      visit sheets_path
    end

    it "#index comments" do
      expect(page).to have_content("おはようございます！シートを作成して作業を整理しましょう！！")
    end

    it "#new comments" do
      click_link "New Sheet"

      expect(page).to have_content("シート名称は「今日やることは？」や「本日タスク」はいかがでしょう？")
    end
  end

  describe "tasks on sheet" do
    before do
      visit sheet_path(sheet_a)
    end

    it "#index comment" do
      expect(page).to have_content("次々空欄を埋めて行きましょう！！優先順位を決めるのは全て埋めてから。")
    end

    it "#create 1 task" do
      click_link "New Task"
      fill_in "Name", with: "タスク1"
      click_button "Create Task"

      expect(page).to have_content("3分以内に全て埋めてしまいましょう！")
    end

    it "#create 2 task" do
      click_link "New Task"
      fill_in "Name", with: "タスク1"
      click_button "Create Task"

      expect(page).to have_content("3分以内に全て埋めてしまいましょう！")
    end

    it "#create 10 task" do
      10.times do
        click_link "New Task"
        fill_in "Name", with: "タスク1"
      click_button "Create Task"

      end

      expect(page).to have_content("残り５つ！！")
    end
  end
  
  describe "choice task" do
    context "重要選択"
    context "緊急選択"
    context "除外選択"
  end
end

