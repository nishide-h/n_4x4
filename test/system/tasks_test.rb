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
    assert_unchecked_field("選択-別日/依頼")
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

    tasks_size = @sheet.tasks.size + 1
    (tasks_size..15).each do |i|
      click_on "New Task"
      fill_in "Name", with: "#{@task.name}#{i}"
      click_on "Create Task"
    end

    assert_text "MyString15"
    assert_css "div.task", count: 15
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

  # test "すでに登録されていれば、表示で重要アイコンが表示されている" do
  test "重要選択されちるものを再選択で重要アイコンが消えること" do
    visit sheet_url(@sheet)
    choose "選択-重要"
    find("div#task_#{ @task.id }").click
    assert_text "Task was successfully updated."
    assert find("#task_#{ @task.id }_select1")

    choose "選択-重要"
    find("div#task_#{ @task.id }").click

    assert_text "Task was successfully updated."
    sleep 1
    assert_raises(Capybara::ElementNotFound) do
      find("#task_#{ @task.id }_select1")
    end
  end

  test "緊急選択モードでクリック時、選択タスクが更新され画像が表示される" do
    visit sheet_url(@sheet)

    choose "選択-緊急"
    find("div#task_#{ @task.id }").click

    assert_text "Task was successfully updated."
    assert find("#task_#{ @task.id }_select2")
  end

  # test "すでに登録されていれば、表示で重要アイコンが表示されている" do
  test "緊急選択されちるものを再選択で緊急アイコンが消えること" do
    visit sheet_url(@sheet)
    choose "選択-緊急"
    find("div#task_#{ @task.id }").click
    assert_text "Task was successfully updated."
    assert find("#task_#{ @task.id }_select2")

    choose "選択-緊急"
    find("div#task_#{ @task.id }").click

    assert_text "Task was successfully updated."
    sleep 1
    assert_raises(Capybara::ElementNotFound) do
      find("#task_#{ @task.id }_select2")
    end
  end

  test "別日/依頼選択モードでクリック時、選択タスクが更新され背景色が変わる" do
    visit sheet_url(@sheet)

    choose "選択-別日/依頼"
    find("div#task_#{ @task.id }").click

    assert_text "Task was successfully updated."
    assert find("div#task_#{ @task.id }").matches_css?(".exclution")
  end

  # test "すでに登録されていれば、表示で重要アイコンが表示されている" do
  test "別日/依頼選択されちるものを再選択で背景色が変わること" do
    visit sheet_url(@sheet)
    choose "選択-別日/依頼"
    find("div#task_#{ @task.id }").click
    assert_text "Task was successfully updated."
    assert find("div#task_#{ @task.id }").matches_css?(".exclution")

    choose "選択-別日/依頼"
    find("div#task_#{ @task.id }").click

    assert_text "Task was successfully updated."
    sleep 1
    assert find("div#task_#{ @task.id }").not_matches_css?(".exclution")
  end

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
