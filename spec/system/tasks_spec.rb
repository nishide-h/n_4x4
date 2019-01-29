require "rails_helper"

describe "Tasks", type: :system do
  let!(:sheet_a) { FactoryBot.create(:sheet) }
  let!(:sheet_b) { FactoryBot.create(:sheet_b) }

  describe "create" do
    before do
      visit sheet_path(sheet_a)
    end

    xit "タスク登録15個まで、連続で登録画面が表示されること"

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
      # find(".task")[0].click
      (all(".task")[0]).click
      # expect(page).to have_selector("img#task_1_select1")
      expect(page).to have_selector("img.select1", count: 1)
      (all(".task")[1]).click
      expect(page).to have_selector("img.select1", count: 2)
      (all(".task")[2]).click
      expect(page).to have_selector("img.select1", count: 3)

      expect(page).to have_selector(".radio.active", text: "選択-緊急＞")
      (all(".task")[3]).click
      expect(page).to have_selector("img.select2", count: 1)
      (all(".task")[4]).click
      expect(page).to have_selector("img.select2", count: 2)
      (all(".task")[5]).click
      expect(page).to have_selector("img.select2", count: 3)

      expect(page).to have_selector(".radio.active", text: "選択-別日/依頼")
      (all(".task")[7]).click
      expect(page).to have_selector(".task.bg-dark", count: 1)
      (all(".task")[8]).click
      expect(page).to have_selector(".task.bg-dark", count: 2)
      (all(".task")[9]).click
      expect(page).to have_selector(".task.bg-dark", count: 3)
      (all(".task")[10]).click
      expect(page).to have_selector(".task.bg-dark", count: 4)

    end
  end

  describe "メッセージ機能" do
    context "シート新規作成直後"
    context "タスク作成中"
    context "重要選択"
    context "緊急選択"
    context "除外選択"
  end
end

