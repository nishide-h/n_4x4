# window.alert 'one'

$ ->
  $('div.task').on 'click', ->
    radioMode = $("input[name='page[mode]']:checked").val()
    sheetId = $("div.container").attr('id').substr(6)
    id =  $(this).attr("id").substr(5)
    alert "クリック モード: #{ radioMode  } シートID：#{sheetId} タスクID: #{ id } "

    switch radioMode
      when 1
        return
        # $.ajax(
        #   url: "/sheets/#{ sheetId }/tasks/#{ id }/toggle_select1"
        #   type: "PATCH" # PUT?
        #   data: sheetId: sheetId, id: id
        # ).done((response) ->
        #   # Railsのアクションが正しく実行された時の処理
        #   return
        # ).fail (xhr) ->
        #   # Railsのアクションなどでエラーが発生した時の処理
        #   return
      when 2
        return
      when 3
        return
      else
        return
  return
return
