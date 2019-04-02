# frozen_string_literal: true

FactoryBot.define do
  factory :sheet do
    title { "本日タスク" }
  end

  factory :valid_sheet, class: Sheet do
    title { "本日タスク" }
    association :user, factory: :valid_user
  end

  factory :sheet_b, class: Sheet do
    title { "今日やるタスク" }
    association :user, factory: :user_b

    after(:create) do |sheet, evaluator|
      create_list(:task_b, 15, sheet: sheet)
    end
  end
end
