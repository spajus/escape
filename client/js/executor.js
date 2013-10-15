(function(Escape) {

  Escape.UpdateMap = function(data) {

    $map = $(Escape.Config.map);

    for (var r = 0; r < data.length; r += 1) {
      var row = $map.find('tr')[r];
      var $row = $(row);

      for (var c = 0; c < data[r].length; c += 1) {
        var cell = $row.find('td')[c];
        var $cell = $(cell);
        $cell.removeClass();

        if (data[r][c] == 1) {
          $cell.addClass('room');
        }
      }
    }
  };



  Escape.FormatOutput = function(input, output) {
    return "\n> " + input + "\n" + output;
  };

  Escape.ExecuteCommand = function(command, callback) {

    $.ajax({
      type: 'POST',
      url: Escape.Config.ServerAction('command'),
      data: {
        command: command
      },
      dataType: 'json',
      success: function(data, status, xhr) {
        callback(data);
      },
      error: function(xhr, errorType, error) {
        callback('' + xhr.status + ': ' + xhr.statusText);
      }
    });

    Escape.UpdateMap([
      [0, 0, 1, 0, 0],
      [1, 0, 1, 1, 0],
      [1, 1, 1, 1, 0],
      [0, 1, 0, 1, 1],
      [0, 1, 0, 0, 1],
      [0, 1, 0, 0, 1],
      [0, 1, 1, 1, 1],
      [0, 1, 0, 0, 1],
      ]);
  };


}(window.Escape = window.Escape || {}));
