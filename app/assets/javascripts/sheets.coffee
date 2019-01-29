# window.alert 'one'

$(document).on 'turbolinks:load', ->
  path = location.pathname
  if document.URL.match(/\/sheets\/\d+$/)
    $('a')[0].focus()
  else if document.URL.match('/tasks/new')
    $('#task_name').focus()

  $('div.task').on 'click', ->
    radioMode = $(".radio.active input").val()
    sheetId = $(".row")[1].id.substr(6)
    id =  $(this).attr("id").substr(5)

    switch radioMode
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
