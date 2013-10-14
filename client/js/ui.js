$(function() {

  var $window = $(window);
  var $map = $('#map');
  var footerHeight = $('#footer').height();
  var $input = $('#input');
  var $output = $('#output');

  var resizeMap = function() { $map.height($window.height() - footerHeight); };
  $window.resize(function(e) { resizeMap(); });
  resizeMap();

  var processCommand = function(input) {
    if (input.toLowerCase() == '/clear') {
      $output.val('');
      return '';
    } else {
      return Escape.FormatOutput(input, Escape.ExecuteCommand(input));
    }
  };

  var appendOutput = function(output) {
    var previous = $output.val();
    if (previous.length > 1000) {
      $output.val(previous.substr(0, 1000) + output);
    } else {
      $output.val(previous + output);
    }
    $output[0].scrollTop = $output[0].scrollHeight;
  }

  $input.keydown(function(e) {
    if (e.keyCode == 13) {
      var input = $input.val();
      var output = processCommand(input);

      appendOutput(output);
      $input.val('');
    }
  });

});
