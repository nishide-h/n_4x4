# frozen_string_literal: true

FactoryBot.define do
  factory :task do
    name { "タスク1" }
    association :sheet, factory: :valid_sheet
  end

  sequence :task_name do |i|
    "タスク#{i}"
  end

  factory :task_b, class: Task do
    name { generate :task_name }
    :sheet_b
  end
end
