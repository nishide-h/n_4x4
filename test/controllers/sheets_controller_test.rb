require 'test_helper'

class SheetsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @sheet = sheets(:one)
  end

  test "should get index" do
    get sheets_url
    assert_response :success
  end

  test "should get new" do
    get new_sheet_url
    assert_response :success
  end

  test "should create sheet" do
    assert_difference('Sheet.count') do
      post sheets_url, params: { sheet: { title: @sheet.title } }
    end

    assert_redirected_to sheet_url(Sheet.last)
  end

  test "should show sheet" do
    get sheet_url(@sheet)
    assert_response :success
  end

  test "should get edit" do
    get edit_sheet_url(@sheet)
    assert_response :success
  end

  test "should update sheet" do
    patch sheet_url(@sheet), params: { sheet: { title: @sheet.title } }
    assert_redirected_to sheet_url(@sheet)
  end

  test "should destroy sheet" do
    assert_difference('Sheet.count', -1) do
      delete sheet_url(@sheet)
    end

    assert_redirected_to sheets_url
  end
end
