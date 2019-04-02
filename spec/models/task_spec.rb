# frozen_string_literal: true

require "rails_helper"

RSpec.describe Task, type: :model do
  before do
    @task = FactoryBot.create(:task)
  end

  it "is valid" do
    expect(@task).to be_valid
  end

  xit "is invalid without name" do
    @task.name = nil
    @task.valid?

    expect(@task.errors[:name]).to include("can't be blank")
  end
end
