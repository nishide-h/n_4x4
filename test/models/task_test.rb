# frozen_string_literal: true

require "test_helper"

class TaskTest < ActiveSupport::TestCase
  setup do
    @task = tasks(:valid)
    # @sheet = sheets(:sheet3)
  end

  test "one task must be valid" do
    assert @task.valid?
  end

  test "task name must not blank" do
    @task.name = ""
    assert @task.invalid?
  end

  test "must have sheet" do
    @task.sheet = nil
    assert @task.invalid?
  end

  test "only 15 tasks on 1 sheet" do
    sheet = sheets(:sheet3)
    (1..14).each do |i|
      Task.create(name: "テスト#{i}", sheet: sheet)
    end

    assert Task.create(name: "テスト15", sheet: sheet).valid?
    assert Task.create(name: "テスト16", sheet: sheet).invalid?
  end
end
