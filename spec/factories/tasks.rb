FactoryBot.define do
  factory :Task do
    name { "タスク1" }
    sheet
  end

  sequence :task_name do |i|
    "タスク#{i}"
  end

  factory :task_b, class: Task do
    name { generate :task_name }
    :sheet_b
  end
end

