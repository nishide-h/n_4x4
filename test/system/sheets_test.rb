# frozen_string_literal: true

require "application_system_test_case"

class SheetsTest < ApplicationSystemTestCase
  setup do
    @sheet = sheets(:valid)
    page.driver.clear_memory_cache
  end

  test "visiting the index" do
    visit sheets_url
    assert_selector "h1", text: "Sheets"
  end

  test "creating a Sheet" do
    visit sheets_url
    click_on "New Sheet"

    fill_in "Title", with: @sheet.title
    click_on "Create Sheet"

    assert_text "Sheet was successfully created"
    click_on "Back"
  end

  test "登録したシート確認" do
    visit sheets_url
    assert_equal 200, status_code

    all(:css, "tbody tr")[0].click_link "Show"
    assert_equal 200, status_code

    assert_text Time.now.strftime("%Y/%m/%d")
    assert_text @sheet.title
  end

  test "updating a Sheet" do
    visit sheets_url
    click_on "Edit", match: :first

    fill_in "Title", with: @sheet.title
    click_on "Update Sheet"

    assert_text "Sheet was successfully updated"
    click_on "Back"
  end

  test "destroying a Sheet" do
    visit sheets_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Sheet was successfully destroyed"
  end
end
