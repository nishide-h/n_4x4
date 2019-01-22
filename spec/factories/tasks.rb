FactoryBot.define do
  factory :Task do
    name { "タスク1" }
    sheet
  end

  factory :max_tasks, class: Task do
    (1..15).each do |i|
      name { "タスク#{i}" }
      association :sheet, factory: :sheet_b
    end
  end
end

