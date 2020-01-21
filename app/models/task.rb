# frozen_string_literal: true

class Task < ApplicationRecord
  belongs_to :sheet

  validates :name, presence: true
  validate :check_number_of_tasks
  validate :select1_number

  private
    def check_number_of_tasks
      if self.sheet && self.sheet.tasks.count > 15
        errors.add(:sheet, "1シートのタスク数は15個までです。")
      end
    end

    def select1_number
      if self.sheet && self.sheet.tasks.where(select1: true).size >= 3
        errors.add(:select1, "選択数は3個までです。")
      end
    end
end
