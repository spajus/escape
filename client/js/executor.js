(function(Escape) {

  Escape.UpdateMap = function(data) {

    $map = $(Escape.Config.map);
    height = $map.width() / Escape.Config.gridHeight;

    for (var r = 0; r < data.length; r += 1) {
      var row = $map.find('tr')[r];
      var $row = $(row);

      for (var c = 0; c < data[r].length; c += 1) {
        var cell = $row.find('td')[c];
        var $cell = $(cell);
        $cell.empty();
        $cell.removeClass();

        var cellClass = 'undef'
        var cellData = data[r][c];
        if (cellData) {
          switch (cellData[0]) {
            case 0: cellClass = 'wall'; break;
            case 1: cellClass = 'room'; break;
            case 2: cellClass = 'forest'; break;
            case 3: cellClass = 'desert'; break;
            case 4: cellClass = 'lake'; break;
            case 5: cellClass = 'river'; break;
            case 6: cellClass = 'hill'; break;
            case 7: cellClass = 'meadow'; break;
            case 8: cellClass = 'chamber'; break;
          }

          if (cellData[1]) {
            $char = $('<div class="char" title="' + cellData[1] + '"></div>');
            $char.appendTo($cell);
            $char.height($char.width());
          }
        }
        $cell.addClass(cellClass);
        $cell.height(height);
      }
    }
  };

  Escape.ExecuteCommand = function(command, callback) {

    $.ajax({
      type: 'POST',
      url: Escape.Config.ServerAction('command'),
      data: {
        command: command,
        since: Escape.since
      },
      dataType: 'json',
      success: function(data, status, xhr) {
        callback(data.res);
        Escape.since = data.time;
        if (data.area) {
          Escape.UpdateMap(data.area);
        }
        if (data.msgs) {
          for (var i = 0; i < data.msgs.length; i++) {
            callback(data.msgs[i]);
          }
        }
      },
      error: function(xhr, errorType, error) {
        callback('' + xhr.status + ': ' + xhr.statusText);
      }
    });
  };


}(window.Escape = window.Escape || {}));
