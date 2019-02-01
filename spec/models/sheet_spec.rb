require 'rails_helper'

RSpec.describe Sheet, type: :model do
  before do
    @sheet = FactoryBot.create(:sheet)
  end

  it "is valid" do
    expect(@sheet).to be_valid
  end

  it "is invalid without title" do
    @sheet.title = nil
    @sheet.valid?

    expect(@sheet.errors[:title]).to include("を入力してください")
  end

  xdescribe "up to 15 tasks on one sheet" do
    before do
      (1..15).each do |i|
        @sheet.tasks.create(name: "タスク#{ i }")
      end
    end
    
    it "only 15 tasks" do
      expect(@sheet).to be_valid
    end
    
    it "over 15 tasks" do
      expect{ @sheet.tasks.create(name: "タスク16") }.to raise_error StandardError
    end
  end
end

