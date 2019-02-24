require "rails_helper"

describe "Tasks", type: :system do
  let!(:sheet_a) { FactoryBot.create(:valid_sheet) }
  let!(:sheet_b) { FactoryBot.create(:sheet_b) }

  context "ユーザーAのとき" do
    before do
      visit new_user_session_path
      fill_in "Eメール", with: sheet_a.user.email
      fill_in "パスワード", with: sheet_a.user.password
      click_button "Log in"
    end

    describe "create" do
      before do
        visit sheet_path(sheet_a)
      end

      xit "タスク登録15個まで、連続で登録画面が表示されること"

      it "タスクが作成できること" do
        (1..15).each do |i|
          click_link "タスク登録"
          fill_in "名称", with: "タスク#{i}"
          click_button "登録する"
          expect(page).to have_content "タスク#{i}"
        end

        expect(page).not_to have_content "タスク登録"
      end
    end

    describe "edit" do
      before do
        visit sheet_path(sheet_a)

        click_link "タスク登録"
        fill_in "名称", with: "edit task"
        click_button "登録する"
      end

      it "タスク編集画面へ遷移できること" do
        (all(".task")[0]).click

        expect(page).to have_selector "h1", text: "タスク編集"
      end

      it "タスク編集ができること" do
        (all(".task")[0]).click
        fill_in "名称", with: "edited task"
        click_button "更新する"

        expect(page).to have_content "edited task"
      end
    end
  end

  context "ユーザーBのとき" do
    before do
      visit new_user_session_path
      fill_in "Eメール", with: sheet_b.user.email
      fill_in "パスワード", with: sheet_b.user.password
      click_button "Log in"
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
  end
end

