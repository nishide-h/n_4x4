# frozen_string_literal: true

require "test_helper"

class TaskTest < ActiveSupport::TestCase
  setup do
    @task = tasks(:valid)
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
end
