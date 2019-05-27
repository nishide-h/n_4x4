# frozen_string_literal: true

class AddStatusToSheets < ActiveRecord::Migration[5.2]
  def up
    add_column :sheets, :status, :integer, default: 0

    Sheet.reset_column_information

    Sheet.find_each do |sheet|
      sheet.update!(status: 0)
    end
  end

  def down
    remove_column :sheets, :status
  end
end
