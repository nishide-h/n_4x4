# frozen_string_literal: true

require "rails_helper"

describe "Messages", type: :system do
  let!(:sheet_a) { FactoryBot.create(:valid_sheet) }
  let!(:sheet_b) { FactoryBot.create(:sheet_b) }

  context "ユーザーAのとき" do
    before do
      visit new_user_session_path
      fill_in "Eメール", with: sheet_a.user.email
      fill_in "パスワード", with: sheet_a.user.password
      click_button "Log in"
    end

    describe "on sheets" do
      before do
        visit sheets_path
      end

      it "#index comments" do
        expect(page).to have_content("おはようございます！シートを作成して作業を整理しましょう！！")
      end

      it "#new comments" do
        click_link "シート作成"

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
        click_link "タスク登録"
        fill_in "名称", with: "タスク1"
        click_button "登録する"

        expect(page).to have_content("3分以内に全て埋めてしまいましょう！")
      end

      it "#create 2 task" do
        click_link "タスク登録"
        fill_in "名称", with: "タスク1"
        click_button "登録する"

        expect(page).to have_content("3分以内に全て埋めてしまいましょう！")
      end

      it "#create 10 task" do
        10.times do
          click_link "タスク登録"
          fill_in "名称", with: "タスク1"
          click_button "登録する"
        end

        expect(page).to have_content("残り5つ！！")
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

    describe "choice task" do
      before do
        visit sheet_path(sheet_b)
      end

      describe "#select1 2 3" do
        it "register completed" do
          expect(page).to have_content("書き上げたタスクを俯瞰して、特に重要なものを３つ選択して下さい。")
        end

        it "#select1 2 3" do
          (all(".task")[0]).click
          sleep(1)
          (all(".task")[1]).click
          expect(page).to have_content("残りひとつです！！")

          (all(".task")[2]).click
          expect(page).to have_content("再び全体を見渡して、緊急性の高いものを３つ選択して下さい。重要と被ってもOK")

          (all(".task")[3]).click
          sleep(1)
          (all(".task")[4]).click
          expect(page).to have_content("残りひとつです！！")

          (all(".task")[5]).click
          expect(page).to have_content("もう一度見渡して、人に頼めるものや今日する必要のないタスクを選択して下さい。個数制限なし")
          expect(page).to have_content("選択が終われば完成ボタンを押して下さい。")
        end
      end
    end
  end
end
