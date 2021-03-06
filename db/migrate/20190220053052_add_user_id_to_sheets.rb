# frozen_string_literal: true

class AddUserIdToSheets < ActiveRecord::Migration[5.2]
  def up
    add_reference :sheets, :user, index: true
    change_column :sheets, :user_id, :integer, null: false
  end

  def down
    remove_reference :sheets, :user, index: true
  end
end
