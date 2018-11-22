# frozen_string_literal: true

require "application_system_test_case"

class TasksTest < ApplicationSystemTestCase
  setup do
    @task = tasks(:valid)
    @sheet = sheets(:valid)
  end

  test "visiting the index" do
    visit sheet_url(@sheet)
    assert_text "本日タスク"
    assert_text "MyString"
    assert_no_text "MyString2"
  end

  test "creating a Task" do
    visit sheet_url(@sheet)
    click_on "New Task"
  
    fill_in "Name", with: "#{@task.name}2"
    click_on "Create Task"
  
    assert_text "Task was successfully created"
    assert_text "本日タスク"
  end
  
  test "creating a Task to 15 items" do
    visit sheet_url(@sheet)

    (2..15).each do |i|
      click_on "New Task"
      fill_in "Name", with: "#{@task.name}#{i}"
      click_on "Create Task"
    end

    assert_text "MyString15"
    assert_text "MyString", count: 15
    assert_no_link "New Task"
    assert_no_text "MyString16"
  end

  #
  # test "updating a Task" do
  #   visit tasks_url
  #   click_on "Edit", match: :first
  #
  #   fill_in "Name", with: @task.name
  #   fill_in "Sheet", with: @task.sheet_id
  #   click_on "Update Task"
  #
  #   assert_text "Task was successfully updated"
  #   click_on "Back"
  # end
  #
  # test "destroying a Task" do
  #   visit tasks_url
  #   page.accept_confirm do
  #     click_on "Destroy", match: :first
  #   end
  #
  #   assert_text "Task was successfully destroyed"
  # end
end
