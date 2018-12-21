# frozen_string_literal: true

require "application_system_test_case"

class TasksTest < ApplicationSystemTestCase
  setup do
    @task = tasks(:valid)
    @sheet = sheets(:valid)
  end

  test "visiting the index on sheet" do
    visit sheet_url(@sheet)
    assert_text "本日タスク"
    assert_text "MyString"
    assert_no_text "MyString2"

    assert_checked_field("登録")
    assert_unchecked_field("選択-重要")
    assert_unchecked_field("選択-緊急")
    assert_unchecked_field("選択-依頼")
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
 
  test "重要選択モードでクリック時、選択タスクが更新され画像が表示される" do
    visit sheet_url(@sheet)

    choose "選択-重要"
    find("div#task_#{ @task.id }").click

    assert_text "Task was successfully updated."
    assert find("#task_#{ @task.id }_select1")
  end
  
  #test "すでに登録されていれば、表示で重要アイコンが表示されている"
  #test "選択-重要モードで、タスクをクリックした時に該当タスクの重要フラグがtru
  #ueになること"
  #test "タスクの重要フラグがTrueであれば、タスクに○が表示されること"
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
