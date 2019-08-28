# frozen_string_literal: true

require "rails_helper"

RSpec.describe Message, type: :model do
  before do
    @sheet = FactoryBot.create(:valid_sheet)
  end

  context "タスク登録時" do
    before do
      @sheet.status = Sheet.statuses[:make_task]
    end

    it "空タスク時" do
      a = Message.new(@sheet)

      expect(a.detail).to eq "次々空欄を埋めて行きましょう！！優先順位を決めるのは全て埋めてから。"
    end

    it "when created first task" do
      @sheet.tasks.create!(name: "タスク１つ目")
      a = Message.new(@sheet)

      expect(a.detail).to eq "3分以内に全て埋めてしまいましょう！"
    end

    it "when created 10 tasks" do
      10.times { |i| @sheet.tasks.create!(name: "タスクテスト#{i}") }
      a = Message.new(@sheet)

      expect(a.detail).to eq "残り5つ！！"
    end
  end

  context "重要タスク選択時" do
    before do
      15.times { |i| @sheet.tasks.create!(name: "タスクテスト#{i}") }
      @sheet.status = Sheet.statuses[:select_1]
    end

    it "select1 description" do
      target = Message.new(@sheet)

      expect(target.detail).to eq "書き上げたタスクを俯瞰して、特に重要なものを３つ選択して下さい。"
    end

    it "select1 last one" do
      2.times { |i| @sheet.tasks[i].update!(select1: :true) }
      # @sheet.tasks.create!(name: "選択テスト", select_1: true)
      target = Message.new(@sheet)

      expect(target.detail).to eq "残りひとつです！！"
    end
  end

  context "緊急タスク選択時" do
    before do
      15.times { |i| @sheet.tasks.create!(name: "タスクテスト#{i}") }
      @sheet.status = Sheet.statuses[:select_2]
    end

    it "select2 description" do
      target = Message.new(@sheet)

      expect(target.detail).to eq "再び全体を見渡して、緊急性の高いものを３つ選択して下さい。重要と被ってもOK"
    end

    it "select2 last one" do
      2.times { |i| @sheet.tasks[i].update!(select2: :true) }
      target = Message.new(@sheet)

      expect(target.detail).to eq "残りひとつです！！"
    end
  end

  context "別日/依頼タスク選択時" do
    before do
      15.times { |i| @sheet.tasks.create!(name: "タスクテスト#{i}") }
      @sheet.status = Sheet.statuses[:select_3]
    end

    it "select3 description" do
      target = Message.new(@sheet)

      expect(target.detail).to eq "もう一度見渡して、人に頼めるものや今日する必要のないタスクを選択して下さい。個数制限なし選択が終われば完成ボタンを押して下さい。"
    end
  end
end

