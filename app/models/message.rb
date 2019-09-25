# frozen_string_literal: true

# 画面のメッセージ管理クラス
class Message

  # Messageインスタンスの作成
  # ==== 引数
  #  * +sheet+ - シートインスタンス
  #  * +action+ - アクション名
  def initialize(sheet=nil, action: nil)
    @sheet = sheet
    @action = action
  end

  # コンストラクタの値からメッセージを返す
  # ==== 戻り値
  # * +string+ - メッセージ文字列
  def detail
    unless @sheet
      case @action
      when "index"
        return "おはようございます！シートを作成して作業を整理しましょう！！"
      when "new"
        return "シート名称は「今日やることは？」や「本日タスク」はいかがでしょう？"
      else
        return  ""
      end
    end

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

