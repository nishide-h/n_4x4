# frozen_string_literal: true

require "rails_helper"

RSpec.describe Sheet, type: :model do
  before do
    @sheet = FactoryBot.create(:valid_sheet)
  end

  it "is valid" do
    expect(@sheet).to be_valid
  end

  it "is invalid without title" do
    @sheet.title = nil
    @sheet.valid?

    expect(@sheet.errors[:title]).to include("を入力してください")
  end
end
