(function() {
  $(document).on('turbolinks:load', function() {
    var path;
    path = location.pathname;
    if (document.URL.match('/sheets/new')) {
      $('#sheet_title').focus();
    } else if (document.URL.match('/tasks/new')) {
      $('#task_name').focus();
    } else if (document.URL.match(/\/sheets\/\d+$/)) {
      $('a.btn-success').focus();
    } else if (document.URL.match('/sheets')) {
      $('.btn-primary').focus();
    }
    $('div.card').on('click', function() {
      var id, sheetId, sheetStatus;
      sheetStatus = $(".border.border-info").text();
      sheetId = $(".row")[1].id.substr(6);
      if (typeof $(this).attr("id") === "undefined") {
        return;
      }
      id = $(this).attr("id").substr(5);
      switch (sheetStatus) {
        case "タスク登録":
          window.location.href = "/sheets/" + sheetId + "/tasks/" + id + "/edit";
          break;
        case "重要タスク選択":
          $.ajax({
            url: "/sheets/" + sheetId + "/tasks/" + id + "/toggle_select1",
            type: "PATCH",
            data: {
              sheetId: sheetId,
              id: id
            }
          }).done(function(response) {}).fail(function(xhr) {});
          break;
        case "緊急タスク選択":
          $.ajax({
            url: "/sheets/" + sheetId + "/tasks/" + id + "/toggle_select2",
            type: "PATCH",
            data: {
              sheetId: sheetId,
              id: id
            }
          }).done(function(response) {}).fail(function(xhr) {});
          break;
        case "別日/依頼タスク選択":
          $.ajax({
            url: "/sheets/" + sheetId + "/tasks/" + id + "/toggle_select3",
            type: "PATCH",
            data: {
              sheetId: sheetId,
              id: id
            }
          }).done(function(response) {}).fail(function(xhr) {});
          break;
      }
    });
  });

  return;

}).call(this);
