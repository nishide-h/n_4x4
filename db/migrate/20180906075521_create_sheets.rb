# frozen_string_literal: true

class CreateSheets < ActiveRecord::Migration[5.2]
  def change
    create_table :sheets do |t|
      t.string :title

      t.timestamps
    end
  end
end
