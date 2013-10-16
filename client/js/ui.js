$(function() {

  var $window = $(window);
  var $map = $('#map');
  var footerHeight = $('#footer').height();
  var $input = $('#input');
  var $output = $('#output');

  var resizeControls = function() {
    $col = $('.col');
    if ($window.height() > $window.width()) {
      $col.removeClass('col-xs-6').addClass('col-md-12');
      $output.height(($window.height() - footerHeight) / 2);
      $map.height(($window.height() - footerHeight) / 2);
      $map.width($output.width());
    } else {
      $col.removeClass('col-md-12').addClass('col-xs-6');
      $map.height($window.height() - footerHeight);
      $output.height($map.height());
      $map.width($output.width());
    }
    $td = $map.find('td');
    if ($td.width() > $td.height()) {
      $map.width($td.height() * Escape.Config.gridHeight);
    } else {
      $map.height($td.width() * Escape.Config.gridWidth);
    }
    $input.focus();
  };

  var processCommand = function(input, callback) {
    if (input.toLowerCase() == '/clear') {
      $output.val('');
      return '';
    } else {
      Escape.ExecuteCommand(input, function(data) {
        callback(Escape.FormatOutput(input, data));
      });
    }
  };

  var appendOutput = function(output) {
    var previous = $output.val();
    var limit = Escape.Config.scrollbackChars;
    if (previous.length > limit) {
      $output.val(previous.substr(previous.length - limit, previous.length) + output);
    } else {
      $output.val(previous + output);
    }
    $output[0].scrollTop = $output[0].scrollHeight;
  }

  var prepareMap = function($map) {
    for (var row = 0; row < Escape.Config.gridHeight; row += 1) {
      var $row = $('<tr></tr>');
      $row.appendTo($map);

      for (var col = 0; col < Escape.Config.gridWidth; col +=1) {
        var $cell = $('<td></td>');
        $cell.appendTo($row);

        if (Escape.Config.IsPlayerSpot(row, col)) {
          drawPlayer($cell);
        }
      }
    }
  }

  var drawPlayer = function($td) {
    $('<div class="player"></div>').appendTo($td);
  }

  $input.keydown(function(e) {
    if (e.keyCode == 13) {
      var input = $input.val();
      processCommand(input, function(data) {
        appendOutput(data);
      });
      $input.val('');
    }
  });

  $window.resize(function(e) { resizeControls(); });

  prepareMap($map);
  resizeControls();
});
