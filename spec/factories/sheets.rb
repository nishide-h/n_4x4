FactoryBot.define do
  factory :sheet do
    title { "本日タスク" }
  end

  factory :sheet_b, class: Sheet do
    title { "今日やるタスク" }
  end
end

