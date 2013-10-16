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

        var cellClass = 'undef'
        switch (data[r][c]) {
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
        $cell.addClass(cellClass);
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
        callback(data.res);
        if (data.area) {
          Escape.UpdateMap(data.area);
        }
      },
      error: function(xhr, errorType, error) {
        callback('' + xhr.status + ': ' + xhr.statusText);
      }
    });
  };


}(window.Escape = window.Escape || {}));
