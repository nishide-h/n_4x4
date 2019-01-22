require "rails_helper"

describe "シート管理機能", type: :system do
  let!(:sheet_a) { FactoryBot.create(:sheet) }
  let!(:sheet_b) { FactoryBot.create(:sheet_b) }

  describe "シート作成" do
    before do
      visit root_path
    end

    it "シートが作成できること" do
      click_link "New Sheet"

      fill_in "Title", with: "今日やること"
      click_button "Create Sheet"

      expect(page).to have_content "今日やること"
    end
  end

  describe "タスク登録する" do
    before do
      visit sheet_path(sheet_a)
    end

    it "タスクが作成できること" do
      (1..15).each do |i|
        click_link "New Task"
        fill_in "Name", with: "タスク#{i}"
        click_button "Create Task"
        expect(page).to have_content "タスク#{i}"
      end

      expect(page).not_to have_content "New Task"
    end
  end

  describe "タスクの重要、緊急、不要の選択を行う" do
    before do
      visit sheet_path(sheet_b)
    end

    it "重要、緊急、廃止を選択していく" do
      expect(page).to have_selector(".radio.active", text: "選択-重要＞")
      find("#task_1").click
      expect(page).to have_selector("img#task_1_select1")
      find("#task_2").click
      expect(page).to have_selector("img#task_2_select1")
      find("#task_3").click
      expect(page).to have_selector("img#task_3_select1")

      expect(page).to have_selector(".radio.active", text: "選択-緊急＞")
      find("#task_4").click
      expect(page).to have_selector("img#task_4_select2")
      find("#task_5").click
      expect(page).to have_selector("img#task_5_select2")
      find("#task_6").click
      expect(page).to have_selector("img#task_6_select2")

      expect(page).to have_selector(".radio.active", text: "選択-別日/依頼")
      find("#task_8").click
      expect(page).to have_selector("img#task_8_select3")
      find("#task_9").click
      expect(page).to have_selector("img#task_9_select3")
      find("#task_10").click
      expect(page).to have_selector("img#task_10_select3")
    end
  end
end

