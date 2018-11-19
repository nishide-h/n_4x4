require 'test_helper'

class SheetTest < ActiveSupport::TestCase
  setup do
    @sheet = sheets(:valid)
  end

  test "sheet must be valid" do
    assert @sheet.valid?
  end

  test "name must not blank" do
    @sheet.title = ""
    assert @sheet.invalid?
  end
end
