# frozen_string_literal: true

User.find_or_create_by!(email: "demo@example.com") do |user|
  user.email = "demo@example.com"
  user.password = "demodemo"
  user.password_confirmation = "demodemo"
end

Sheet.find_or_create_by!(id: 1) do |sheet|
  sheet.title = "デモシート"
  sheet.user_id = 1
  sheet.status = 0
end

15.times do |i|
  Task.find_or_create_by!(id: i+1) do |task|
    task.name = "タスク#{ i+1 }"
    task.sheet_id = 1
  end
end

Sheet.create!(id: 2, title: "本日タスク", user_id: 1, status: 0)
Task.create!(name: "課題の仕様確認", select1: true, sheet_id: 2)
Task.create!(name: "Seedファイル作成", select3: true, sheet_id: 2)
Task.create!(name: "テストコード", sheet_id: 2)
Task.create!(name: "実装", select2: true, sheet_id: 2)
Task.create!(name: "Gemファイル適応", select3: true, sheet_id: 2)
Task.create!(name: "Ruby VerUP", select2: true, sheet_id: 2)
Task.create!(name: "筋トレ HIIT", sheet_id: 2)
Task.create!(name: "プレゼント検討", select1: true, sheet_id: 2)
Task.create!(name: "Vim学習", sheet_id: 2)
Task.create!(name: "買出し プロテイン", select3: true, sheet_id: 2)
Task.create!(name: "掃除 玄関", sheet_id: 2)
Task.create!(name: "不動産 メール返信", select1: true, select2: true, sheet_id: 2)
Task.create!(name: "VSCode調査", select3: true, sheet_id: 2)
Task.create!(name: "学習内容の出力", sheet_id: 2)
Task.create!(name: "はてなにGoogleAdsense反映", select3: true, sheet_id: 2)

