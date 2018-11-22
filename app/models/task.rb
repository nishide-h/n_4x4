# frozen_string_literal: true

class Task < ApplicationRecord
  belongs_to :sheet

  validates :name, presence: true
  validate :check_number_of_tasks

  private
    def check_number_of_tasks
      if self.sheet && self.sheet.tasks.count > 15
        errors.add(:sheet, "1シートのタスク数は15個までです。")
      end
    end
end
