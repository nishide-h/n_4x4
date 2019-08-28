# frozen_string_literal: true

class Message
  # sheet情報を受取、そのときのメッセージを返す
  def initialize(sheet)
    @sheet = sheet
  end

  def detail
    task_count = @sheet.tasks.count

    if @sheet.make_task?
      if task_count == 1
        return "3分以内に全て埋めてしまいましょう！"
      end

      if task_count < 10
        return "次々空欄を埋めて行きましょう！！優先順位を決めるのは全て埋めてから。"
      end

      if task_count < 15
        return "残り#{ 15 - task_count.to_i }つ！！"
      end
    end
  end
end
