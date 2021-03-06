# frozen_string_literal: true

require "rails_helper"

describe "Sheet", type: :system do
  let!(:user_a) { FactoryBot.create(:valid_user) }
  let!(:user_b) { FactoryBot.create(:valid_user, email: "user_b@example.com") }
  let!(:sheet_a) { FactoryBot.create(:sheet, title: "シートA", user: user_a) }
  let!(:sheet_b) { FactoryBot.create(:sheet, title: "シートB",  user: user_b) }
  let!(:sheet_c) { FactoryBot.create(:sheet, title: "シートC", updated_at: Date.today + 1, user: user_a) }
  let!(:sheet_prev) { FactoryBot.create(:sheet, title: "前へシート", status: "finished", user: user_a) }

  describe "#index" do
    context "ユーザーAアカウント" do
      before do
        visit new_user_session_path
        fill_in "Eメール", with: user_a.email
        fill_in "パスワード", with: user_a.password
        click_button "Log in"
      end

      it "シート一覧が表示されること" do
        expect(page).to have_content "シートA"
        expect(page).to have_link "シート作成"
      end

      it "更新日でシートが並んでいること" do
        expect(page).to have_selector "th", text: "更新日"
        expect(all("tr td")[0].text).to eq "シートC"
      end

      it "一覧にメッセージが表示されていること" do
        expect(page).to have_content "おはようございます！シートを作成して作業を整理しましょう！！"
      end
    end

    context "ユーザーBアカウント" do
      before do
        visit new_user_session_path
        fill_in "Eメール", with: user_b.email
        fill_in "パスワード", with: user_b.password
        click_button "Log in"
      end

      it "シート一覧が表示されること" do
        expect(page).to have_content "シートB"
        expect(page).to have_link "シート作成"
      end

      it "ユーザーAアカウントのしーとが表示されていないこと" do
        expect(page).not_to have_content "シートA"
      end
    end
  end

  describe "#index paging" do
    before do
      100.times { |i| user_a.sheets.create!(title: "ページングテスト#{i}") } # for paging test

      visit new_user_session_path
      fill_in "Eメール", with: user_a.email
      fill_in "パスワード", with: user_a.password
      click_button "Log in"
    end

    it "ページングで25件まで表示されること" do
      expect(page).to have_content "25件のシートが表示されています"
      expect(all("tbody tr").count).to eq 25
    end
  end

  describe "#create" do
    before do
      visit new_user_session_path
      fill_in "Eメール", with: user_a.email
      fill_in "パスワード", with: user_a.password
      click_button "Log in"
    end

    it "シート作成画面にメッセージが表示されること" do
      click_link "シート作成"

      expect(page).to have_content "シート名称は「今日やることは？」や「本日タスク」はいかがでしょう？"
    end

    it "シートが作成でき、一覧に表示されること" do
      click_link "シート作成"

      fill_in "シート名", with: "今日やること"
      click_button "登録する"

      expect(page).to have_content "今日やること"
    end
  end

  describe "#next_status" do
    before do
      visit new_user_session_path
      fill_in "Eメール", with: user_a.email
      fill_in "パスワード", with: user_a.password
      click_button "Log in"
      visit sheet_path(sheet_a)
    end

    it "タスク登録時、モード戻るボタンが表示されていないこと" do
      expect(page).not_to have_link "<"
    end

    it ">ボタンクリックで次のステータスへ更新されること" do
      expect(page).to have_content "タスク登録"
      click_link ">"

      expect(page).to have_content "重要タスク選択"
    end
  end

  describe "#prev_status" do
    before do
      visit new_user_session_path
      fill_in "Eメール", with: user_a.email
      fill_in "パスワード", with: user_a.password
      click_button "Log in"
      visit sheet_path(sheet_prev)
    end

    it "タスク登録時、次のモードへ遷移するボタンが表示されていないこと" do
      expect(page).not_to have_link ">"
    end

    it ">ボタンクリックで次のステータスへ更新されること" do
      expect(page).to have_content "完成"
      click_link "<"

      expect(page).to have_content "別日/依頼タスク選択"
    end
  end
end
