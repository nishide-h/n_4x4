# window.alert 'one'

$(document).on 'turbolinks:load', ->
  path = location.pathname
  if document.URL.match('/sheets/new')
    $('#sheet_title').focus()
  else if document.URL.match('/tasks/new')
    $('#task_name').focus()
  else if document.URL.match(/\/sheets\/\d+$/)
    $('a.btn-success').focus()
  else if document.URL.match('/sheets')
    $('.btn-primary').focus()
  
  $('div.card').on 'click', ->
    sheetStatus = $(".badge.badge-info").text() 
    sheetId = $(".row")[1].id.substr(6)
    if typeof $(this).attr("id") == "undefined" 
      return
    id =  $(this).attr("id").substr(5)

    switch sheetStatus
      when "タスク登録"
        window.location.href = "/sheets/#{ sheetId }/tasks/#{ id }/edit"
        return
      when "1"
        # alert "クリック モード: #{ radioMode  } シートID：#{sheetId} タスクID: #{ id } "
        $.ajax(
          url: "/sheets/#{ sheetId }/tasks/#{ id }/toggle_select1"
          type: "PATCH" # PUT?
          data: sheetId: sheetId, id: id
        ).done((response) ->
          # Railsのアクションが正しく実行された時の処理
          return
        ).fail (xhr) ->
          # Railsのアクションなどでエラーが発生した時の処理
          return
        return
      when "2"
        $.ajax(
          url: "/sheets/#{ sheetId }/tasks/#{ id }/toggle_select2"
          type: "PATCH"
          data: sheetId: sheetId, id: id
        ).done((response) ->
          return
        ).fail (xhr) ->
          return
        return
      when "3"
        $.ajax(
          url: "/sheets/#{ sheetId }/tasks/#{ id }/toggle_select3"
          type: "PATCH"
          data: sheetId: sheetId, id: id
        ).done((response) ->
          return
        ).fail (xhr) ->
          return
        return
      else
        return
  return
return
