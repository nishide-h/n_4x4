# frozen_string_literal: true

class Message
  # sheet情報を受取、そのときのメッセージを返す
  def initialize(sheet)
    @sheet = sheet
  end

  def detail
    case @sheet.tasks.count
    when 0
      "次々空欄を埋めて行きましょう！！優先順位を決めるのは全て埋めてから。"
    when 10
      ""
    when 14
      ""
    else
      ""
    end
  end
end
