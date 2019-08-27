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

    it "タスクを10個登録時" do
      10.times { |i| @sheet.tasks.create!(name: "タスクテスト#{i}") }
      a = Message.new(@sheet)

      expect(a.detail).to eq "残り5つ！！"
    end
    it "タスクを12個登録時"
    it "タスクを14個登録時"

    xit "is invalid without name" do
      @task.name = nil
      @task.valid?

      expect(@task.errors[:name]).to include("can't be blank")
    end
  end

  context "タスク選択時"
end
