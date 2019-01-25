FactoryBot.define do
  factory :sheet do
    title { "本日タスク" }
  end

  factory :sheet_b, class: Sheet do
    title { "今日やるタスク" }

    after(:create) do |sheet, evaluator|
      create_list(:task_b, 15, sheet: sheet)
    end
  end
end

