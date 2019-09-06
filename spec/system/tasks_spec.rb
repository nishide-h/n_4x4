# frozen_string_literal: true

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
        end

        expect(page).not_to have_link "タスク登録"

        cards_title = all(".card-title").map(&:text)
        cards_title.delete_at(0)
        expect(cards_title).to eq ["タスク1", "タスク2", "タスク3", "タスク4", "タスク5", "タスク6", "タスク7", "タスク8", "タスク9", "タスク10", "タスク11", "タスク12", "タスク13", "タスク14", "タスク15"]
      end

      it "１５個タスク登録時、自動遷移すること" do
        (1..14).each do |i|
          click_link "タスク登録"
          fill_in "名称", with: "タスク#{i}"
          click_button "登録する"
        end

        click_link "タスク登録"
        fill_in "名称", with: "タスク15"
        click_button "登録する"

        expect(page).to have_content "重要タスク選択"
        expect(page).to have_content "タスク15"
      end
    end

    describe "edit" do
      before do
        visit sheet_path(sheet_a)

        click_link "タスク登録"
        fill_in "名称", with: "task1"
        click_button "登録する"
        click_link "タスク登録"
        fill_in "名称", with: "edit task"
        click_button "登録する"
      end

      it "タスク編集画面へ遷移できること" do
        (all(".task")[1]).click

        expect(page).to have_selector "h1", text: "タスク編集"
      end

      it "タスク編集ができること" do
        (all(".task")[1]).click
        fill_in "名称", with: "edited task"
        click_button "更新する"

        expect(page).to have_content "edited task"

        cards_title = all(".card-title").map(&:text)
        cards_title.delete_at(0)
        expect(cards_title).to eq ["task1", "edited task"]
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

      it "重要タスクを選択できる" do
        click_link ">"
        expect(page).to have_selector(".border.border-info", text: "重要タスク選択")

        (all(".task")[0]).click
        expect(page).to have_selector("img.select1", count: 1)
      end

      it "緊急タスクを選択できる" do
        click_link ">"
        click_link ">"
        expect(page).to have_selector(".border.border-info", text: "緊急タスク選択")

        (all(".task")[3]).click
        expect(page).to have_selector("img.select2", count: 1)
      end

      it "別日/依頼タスクを選択できる" do
        click_link ">"
        click_link ">"
        click_link ">"
        expect(page).to have_selector(".border.border-info", text: "別日/依頼タスク選択")

        (all(".task")[7]).click
        expect(page).to have_selector(".task.bg-dark", count: 1)
      end
    end
  end
end
