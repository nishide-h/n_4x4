# frozen_string_literal: true

class Message
  # sheet情報を受取、そのときのメッセージを返す
  def initialize(sheet)
    @sheet = sheet
  end

  def detail
    task_count = @sheet.tasks.size

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

    if @sheet.select_1?
      select1_count = @sheet.tasks.where(select1: :true).size
      
      if select1_count == 0
        return "書き上げたタスクを俯瞰して、特に重要なものを３つ選択して下さい。"
      end

      if select1_count == 2
        return "残りひとつです！！"
      end
    end

    if @sheet.select_2?
      select2_count = @sheet.tasks.where(select2: :true).size
      
      if select2_count == 0
        return "再び全体を見渡して、緊急性の高いものを３つ選択して下さい。重要と被ってもOK"
      end

      if select2_count == 2
        return "残りひとつです！！"
      end
    end

    if @sheet.select_3?
      return "もう一度見渡して、人に頼めるものや今日する必要のないタスクを選択して下さい。"
    end

    if @sheet.finished?
      return "これでシート完成です！！タスクをスケジュールに登録しましょう。"
    end
  end
end

